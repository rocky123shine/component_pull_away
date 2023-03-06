const String riseUrlConfig = r'''
  query RiseUrlConfig{
    appSetting{
        privacy_policy_url
        about_rise_url
        about_us_url_new
        user_policy_url
        recommend_course_url
    }
  }
''';

const String searchRepositories = r'''
  query SearchRepositories($nRepositories: Int!, $query: String!, $cursor: String) {
    search(last: $nRepositories, query: $query, type: REPOSITORY, after: $cursor) {
      nodes {
        __typename
        ... on Repository {
          name
          shortDescriptionHTML
          viewerHasStarred
          stargazers {
            totalCount
          }
          forks {
            totalCount
          }
          updatedAt
        }
      }
      pageInfo {
        endCursor
        hasNextPage
      }
    }
  }
''';

const String testSubscription = r'''
		subscription test {
	    deviceChanged(id: 2) {
	      __typename
        id
        name
      }
		}
''';
