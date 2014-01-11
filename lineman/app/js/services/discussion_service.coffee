angular.module('loomioApp').service 'DiscussionService',
  class DiscussionService
    constructor: (@$http, @RecordCacheService) ->

    remoteGet: (id) ->
      collectionNames =  ['discussions', 'proposals', 'authors', 'events', 'comments']
      @$http.get("/api/discussions/#{id}").then (response) =>
        discussion = response.data.discussion
        @RecordCacheService.consumeSideLoadedRecords(response.data, collectionNames)
        @RecordCacheService.hydrateRelationshipsOn(discussion)
        @RecordCacheService.put('discussions', discussion.id, discussion)
        discussion
      , (response) ->
        saveError(response.data.error)
