import 'package:lafyuu/core/network/dio_helper.dart';

import '../../../../core/network/end_points.dart';
import '../models/search_model.dart';

abstract class SearchRemoteDataSources {
  Future<SearchModel> search(String text);
}

class SearchRemoteDataSourcesImpl implements SearchRemoteDataSources {
  final DioHelper _dioHelper;
  SearchRemoteDataSourcesImpl(this._dioHelper);

  @override
  Future<SearchModel> search(String text) async {
    final response = await _dioHelper.post(
      endPoint: searchEndPoint,
      token: token ?? '',
      data: {
        'text': text,
      },
    );
    return SearchModel.fromJson(response);
  }
}
