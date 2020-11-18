const token = process.env.DADATA_TOKEN
const url = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/party'

export function DadataClient (query) {
  const result = fetch(url, {
    method: 'POST',
    mode: 'cors',
    headers: {
      'Content-Type': 'application/json',
      Accept: 'application/json',
      Authorization: `Token ${token}`
    },
    body: JSON.stringify({ query: query })
  }).then(result => result.json())
  return result
}
