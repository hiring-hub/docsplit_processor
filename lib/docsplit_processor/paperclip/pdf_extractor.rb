require 'paperclip'
require 'docsplit'

module Paperclip
  class PdfExtractor < Processor
    def make
      if original_cv_is_pdf?
        File.open(input_file_path)
      else
        Docsplit.extract_pdf(input_file_path, output: destination_dir)
        File.open(output_file_path)
      end
    rescue StandardError => exception
      input_file_path = input_file_path
      file.close!
      raise Paperclip::Error, "Error converting '#{input_file_path}' to pdf\nError caught: #{exception.backtrace.join('\n')}"
    end

    private

    def original_cv_is_pdf?
      input_file_path.match(/pdf$/)
    end

    def input_file_path
      file.path
    end

    def destination_dir
      File.dirname(input_file_path)
    end

    def output_file_path
      "#{destination_dir}/#{output_base_name}"
    end

    def output_base_name
      "#{input_base_name}.pdf"
    end

    def input_base_name
      File.basename(input_file_path, '.*')
    end
  end
end
