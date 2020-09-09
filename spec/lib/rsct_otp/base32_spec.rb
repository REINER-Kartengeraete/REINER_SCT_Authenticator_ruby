# MIT LICENSE
#
# $Date: Wed Jul 22 11:43:18 2020 +0200$
# $Rev: v1.0.0-18-ge8d4816$

require 'spec_helper'

RSpec.describe RSCT_OTP::Base32 do
  describe '.random' do
    context 'without arguments' do
      let(:base32) { RSCT_OTP::Base32.random }

      it 'is 20 bytes (160 bits) long (resulting in a 32 character base32 code)' do
        expect(RSCT_OTP::Base32.decode(base32).length).to eq 20
        expect(base32.length).to eq 32
      end

      it 'is base32 charset' do
        expect(base32).to match(/\A[A-Z2-7]+\z/)
      end
    end

    context 'with arguments' do
      let(:base32) { RSCT_OTP::Base32.random 48 }

      it 'returns the appropriate byte length code' do
        expect(RSCT_OTP::Base32.decode(base32).length).to eq 48
      end
    end
  end

  describe '.decode' do
    context 'corrupt input data' do
      it 'raises a sane error' do
        expect { RSCT_OTP::Base32.decode('4BCDEFG234BCDEF1') }.to \
          raise_error(RSCT_OTP::Base32::Base32Error, "Invalid Base32 Character - '1'")
      end
    end

    context 'valid input data' do
      it 'correctly decodes a string' do
        expect(RSCT_OTP::Base32.decode('2EB7C66WC5TSO').unpack('H*').first).to eq 'd103f17bd6176727'
        expect(RSCT_OTP::Base32.decode('Y6Y5ZCAC7NABCHSJ').unpack('H*').first).to eq 'c7b1dc8802fb40111e49'
      end

      it 'correctly decode strings with trailing bits (not a multiple of 8)' do
        # Dropbox style 26 characters (26*5==130 bits or 16.25 bytes, but chopped to 128)
        # Matches the behavior of Google Authenticator, drops extra 2 empty bits
        expect(RSCT_OTP::Base32.decode('YVT6Z2XF4BQJNBMTD7M6QBQCEM').unpack('H*').first).to eq 'c567eceae5e0609685931fd9e8060223'

        # For completeness, test all the possibilities allowed by Google Authenticator
        # Drop the incomplete empty extra 4 bits (28*5==140bits or 17.5 bytes, chopped to 136 bits)
        expect(RSCT_OTP::Base32.decode('5GGZQB3WN6LD7V3L5HPDYTQUANEQ').unpack('H*').first).to eq 'e98d9807766f963fd76be9de3c4e140349'

      end

      context 'with padding' do
        it 'correctly decodes a string' do
          expect(RSCT_OTP::Base32.decode('234A===').unpack('H*').first).to eq 'd6f8'
        end
      end

    end
  end

  describe '.encode' do
    context 'encode input data' do
      it 'correctly encodes data' do
        expect(RSCT_OTP::Base32.encode(hex_to_bin('3c204da94294ff82103ee34e96f74b48'))).to eq 'HQQE3KKCST7YEEB64NHJN52LJA'
      end
    end
  end

end

def hex_to_bin(s)
  s.scan(/../).map { |x| x.hex }.pack('c*')
end
