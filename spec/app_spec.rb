require_relative 'spec_helper'

describe 'App' do
  it 'should hit the healthcheck' do
    get '/'

    expect(last_response.status).to eq(418)
    expect(json_spec_response["message"]).to eq("hey, everything is okay!")
  end

  describe '/horoscope' do
    context 'with acceptable zodiac sign' do
      let(:json_body) do
        [
          {
            text: "<h2>YO</h2>"
          }
        ].to_json
      end

      it "returns a horoscope" do
        expect(Net::HTTP).to receive(:get).and_return(json_body)

        post '/horoscope', { text: "gemini" }

        expect(last_response.status).to eq(200)
        expect(json_spec_response["text"]).to eq("GEMINI: YO")
      end
    end

    context 'with zodiac sign that does not exist' do
      let(:expected_message) do
        "HOWDY: Hey dummy, that's not a proper zodiac sign. Reach out to Mike Cassano if you need help figuring out what they are. He's an astrological expert!"
      end

      it 'returns an error message' do
        post '/horoscope', { text: "howdy" }

        expect(last_response.status).to eq(200)
        expect(json_spec_response["text"]).to eq(expected_message)
      end
    end
  end
end
