library comfy_deploy_client;

import 'package:comfy_deploy_client/types.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'comfy_deploy_client.g.dart';

@RestApi(baseUrl: 'https://www.comfydeploy.com/api')
abstract class ComfyDeployClient {
  factory ComfyDeployClient({
    required String apiKey,
    Dio? dio,
    String? baseUrl,
  }) {
    final clientDio = dio ?? Dio();
    clientDio.options.headers['authorization'] = 'Bearer $apiKey';

    return _ComfyDeployClient(clientDio, baseUrl: baseUrl);
  }

  @GET('/upload-url')
  Future<UploadUrlResult> getUploadUrl({
    @Query('type') required String type,
    @Query('file_size') required int fileSize,
  });

  @POST('/run')
  Future<RunResult> postRun({
    @Body() required RunData data,
  });

  @GET('/run')
  Future<RunOutputResult> getRun({
    @Query('run_id') required String runId,
  });

  @GET('/websocket/{deploymentId}')
  Future<WebsocketResult> getWebsocket({
    @Path() required String deploymentId,
  });
}
