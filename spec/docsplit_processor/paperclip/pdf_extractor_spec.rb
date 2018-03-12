require 'spec_helper'

module Paperclip
  RSpec.describe PdfExtractor do
    describe '#make' do
      subject { PdfExtractor.new(file, output: dir).make }

      let(:file) { double('File', path: file_path) }
      let(:file_path) { "#{dir}/test.docx" }
      let(:pdf_path) { "#{dir}/test.pdf" }
      let(:dir) { './temp_dir' }

      before do
        allow(Docsplit).to receive(:extract_pdf).with(file_path, output: dir)
        allow(File).to receive(:open).with(pdf_path)
      end

      it 'converts any format files to pdfs' do
        expect(Docsplit).to receive(:extract_pdf).with(file_path, output: dir)

        subject
      end

      it 'returns a file' do
        expect(File).to receive(:open).with(pdf_path)

        subject
      end

      context 'when the CV is already a pdf' do
        let(:file_path) { "#{dir}/test.pdf" }

        it 'returns the original document' do
          expect(File).to receive(:open).with(file_path)

          subject
        end

        it 'does not process the document with docsplit' do
          expect(Docsplit).not_to receive(:extract_pdf).with(any_args)

          subject
        end
      end

      context 'when docsplit fails' do
        before do
          allow(Docsplit).to receive(:extract_pdf)
            .with(file_path, output: dir).and_raise(StandardError)
        end

        it 'raises a paperclip error' do
          expect { subject }.to raise_error(Paperclip::Error)
        end
      end
    end
  end
end
