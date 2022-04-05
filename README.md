# flutter_structure

A base Flutter project.

## Enviroment
- Flutter 2.10

## IDE Plugins (recommend)
- GetX Snippets
- Flutter Intl
- Region folding

## Structure
Use `GetX` with `MVC`

![Structure](/strc_module.png)

- Routes : Chứa các file quản lý route của app (điều hướng màn hình). Trong thực tế, `Routes` nằm trong thư mục `Config`.
- Modules: Chia theo màn hình, bao gồm file view và controller (dùng binding để kết nối view và controller). Ở đây có thể chia nhỏ view thành các widget trong thư mục `widgets`.
- Data: Là thư mục cha chứa tất cả mọi thứ liên quan tới data:
  - Repository: Chia theo model, là nơi truy cập duy nhất tới mỗi model (`single point of access to data`)
  - Provider: Tương ứng với `Service`, là các file cung cấp phương thức truy cập tới data, ví dụ api, socket, local storage, ...
  - Model: Chứa các file model.
- Constants: Các constants sẽ được nhóm lại trong các file như `Keys`, `Colors`, ...
- Global Widgets: Chứa các widget dùng chung trong app.
- Helpers: Chứa các file extension, utils..

## Some features
### Base api
- `http_client` sử dụng Dio để request api, parse dữ liệu vào `BaseApiResponse<T>`, với T là model tương ứng từng api
- `BaseApiResponse<T>` dùng để parse dữ liệu theo format chung của tất cả api, bao gồm `status`, `data`, `message`. Có thể thay đổi tuỳ theo hệ thống service mỗi dự án. Khi đó, mỗi api sẽ chỉ cần quan tâm model thật sự bên trong.
- Mỗi request sẽ trả ra object `ServiceResponse`, tuỳ theo trạng thái của request, sẽ có `status` là `success`, `error`. Bên cạnh đó, có thêm một trạng thái là `loading`, phục vụ hiển thị trên view.

```dart
ServiceResponse<AuthenData> response = await apiClient.requestPost(
    ApiPath.signIn,
    {Keys.userName: userName, Keys.password: password},
    (json) => BaseApiResponse.fromJson(
            json,
            (data) => AuthenData.fromJson(data),
        ),
    );
switch (response.status) {
    case ServiceStatus.completed:
        saveAuthCredential(response.data);
        return true;
    default:
        return false;
    }
```

### Flavor
- Không dùng file `main.dart`, thay vì đó sẽ là `main_dev.dart`, `main_staging.dart` hoặc `main_product.dart`, tương ứng từng mỗi môi trường server.
- Mỗi môi trường bao gồm các thông tin về đường dẫn api, socket hay media.

```
flutter run lib/config/main/main_product.dart
```

### Multilanguage
- Tích hợp phần đa ngôn ngữ của Flutter với lib `intl`. Mặc định là `vi` và `en`.
- Sử dụng thêm plugin trong IDE để được gen key tự động.

### ScrollView with placeholder, pull to refresh and load more
- Một widget tích hợp sẵn các chức năng thường có ở một list hoặc grid. 
- Dùng với `SliverList` hoặc `SliverGrid`.

### Multi Image Picker
- Màn hình cho phép chọn một hoặc nhiều ảnh hoặc video.
- Có thể giới hạn số lượng có thể chọn.
- Không dùng lib `image_picker` vì lib không hỗ trợ hiển thị và thao tác với các item đã chọn trước đó.


## Coding Convention
https://dart.dev/guides/language/effective-dart
