class PaginationResponse<T> {
  final int page;
  final T results;
  final int totalPages;
  final int totalResults;

  PaginationResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PaginationResponse.empty() => PaginationResponse(
        page: 0,
        results: [] as T,
        totalPages: 0,
        totalResults: 0,
      );

  factory PaginationResponse.fromJson(Map<String, dynamic> json, T results) {
    return PaginationResponse(
      page: json['page'] as int,
      results: results,
      totalPages: json['total_pages'] as int,
      totalResults: json['total_pages'] as int,
    );
  }

  PaginationResponse copyWith({
    int? page,
    T? results,
    int? totalPages,
    int? totalResults,
  }) =>
      PaginationResponse(
        page: page ?? this.page,
        results: results ?? this.results,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );
}
