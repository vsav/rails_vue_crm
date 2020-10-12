const token = 'e35d0ba53d404b91c45c61e979d327d43993bb9f';
const url = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/party';

export default class dadataClient {
  constructor(query) {
    this.query = query
  }
  async organizations() {
    const result = await fetch(url, {
      method: 'POST',
      mode: "cors",
      headers: {
        'Content-Type': 'application/json',
        Accept: 'application/json',
        Authorization: `Token ${token}`,
      },
      body: JSON.stringify({ query: this.query }),
    }).then(result => result.json());
    return result;
  }
}
