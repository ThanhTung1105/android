# SafeTrek - Ứng dụng An toàn Cá nhân (Personal Safety App)

SafeTrek là một ứng dụng di động được thiết kế để nâng cao sự an toàn cá nhân, đặc biệt hữu ích khi người dùng di chuyển một mình hoặc vào ban đêm. Ứng dụng cung cấp các tính năng cốt lõi như theo dõi hành trình, kích hoạt cảnh báo SOS khẩn cấp và các công cụ bảo vệ khác.

## 🚀 Tính năng nổi bật

* **Bắt đầu chuyến đi an toàn:** Thiết lập điểm đến và thời gian dự kiến cho chuyến đi của bạn. Ứng dụng sẽ giám sát hành trình và cảnh báo nếu có bất thường.
* **SOS Khẩn cấp:** Nút SOS lớn, dễ tiếp cận để gửi cảnh báo khẩn cấp ngay lập tức đến các liên hệ tin cậy của bạn.
* **Giám sát hành trình (Đang phát triển):** Xem vị trí hiện tại của bạn trên bản đồ và trạng thái giám sát chuyến đi.
* **Thông báo & Cảnh báo (Đang phát triển):** Nhận các thông báo quan trọng và cảnh báo an toàn.
* **Quản lý Hồ sơ:** Xem và chỉnh sửa thông tin cá nhân, cài đặt tài khoản.
* **Xác thực người dùng:** Đăng ký, đăng nhập, quên và đặt lại mật khẩu.

## 📁 Cấu trúc Dự án

Dự án này tuân theo cấu trúc **Phân tầng (Layered Architecture)** để đảm bảo sự rõ ràng, dễ bảo trì và mở rộng. Dưới đây là mô tả chi tiết các thư mục và file chính:
### 🎯 Giải thích các Thư mục Chính

* ### `lib/main.dart`
    * **Chức năng:** Điểm khởi chạy chính của ứng dụng. Nơi thiết lập các dependency injection (`GetIt`), cấu hình `MultiProvider` và chạy widget gốc (`MyApp`) của ứng dụng.

* ### `lib/injection_container.dart`
    * **Chức năng:** Quản lý Dependency Injection (DI) sử dụng thư viện `GetIt`. Đăng ký các `Service` và `ViewModel` để chúng có thể được inject vào các phần khác của ứng dụng một cách dễ dàng và hiệu quả.

* ### `lib/models/`
    * **Chức năng:** Chứa các định nghĩa cấu trúc dữ liệu (Data Models/Entities) được sử dụng trong toàn bộ ứng dụng.
        * `user.dart`: Định nghĩa cấu trúc dữ liệu của đối tượng người dùng (ID, email, fullName, v.v.), bao gồm các phương thức `fromJson`/`toJson` để chuyển đổi dữ liệu.
        * `onboarding_page_content.dart`: Định nghĩa cấu trúc dữ liệu cho nội dung hiển thị trên mỗi trang của màn hình Onboarding (tiêu đề, mô tả, ảnh).

* ### `lib/services/`
    * **Chức năng:** Chứa các **Service** chịu trách nhiệm xử lý logic nghiệp vụ và giao tiếp với các nguồn dữ liệu bên ngoài (như API backend hoặc mock data).
        * `auth_service.dart`: Xử lý tất cả các hoạt động liên quan đến xác thực người dùng (đăng nhập, đăng ký, quên/đặt lại mật khẩu, đăng xuất) và quản lý trạng thái người dùng hiện tại (sử dụng mock data).

* ### `lib/screens/`
    * **Chức năng:** Chứa tất cả các màn hình giao diện người dùng (UI) chính của ứng dụng, cùng với các thành phần quản lý trạng thái (`ViewModel`/`State`) đi kèm.
        * `splash_screen.dart`: Màn hình khởi động, kiểm tra trạng thái đăng nhập và điều hướng phù hợp.
        * `onboarding_screen.dart`: Màn hình giới thiệu ban đầu của ứng dụng.
        * `login_screen.dart`: Màn hình đăng nhập.
        * `register_screen.dart`: Màn hình đăng ký tài khoản mới.
        * `forgot_password_screen.dart`: Màn hình yêu cầu đặt lại mật khẩu.
        * `reset_password_screen.dart`: Màn hình cho phép người dùng đặt mật khẩu mới.
        * `dashboard_screen.dart`: Màn hình chính sau khi đăng nhập, chứa `BottomNavigationBar` và quản lý các tab.
        * `home_tab_screen.dart`: Tab Trang chủ, hiển thị trạng thái an toàn, nút "Bắt đầu chuyến đi mới" và nút "SOS Khẩn cấp".
        * `trip_setup_screen.dart`: Màn hình cho phép người dùng thiết lập điểm đến và thời gian dự kiến cho chuyến đi an toàn mới.
        * `safety_monitoring_tab_screen.dart`: (Giao diện) Tab giám sát an toàn.
        * `alerts_tab_screen.dart`: (Giao diện) Tab hiển thị các thông báo và cảnh báo.
        * `profile_tab_screen.dart`: Tab hồ sơ người dùng, cho phép xem và chỉnh sửa thông tin cá nhân, cài đặt tài khoản.
        * `auth_view_model.dart`: Quản lý trạng thái liên quan đến xác thực (đăng nhập, đăng ký, lỗi, thành công) và giao tiếp với `AuthService`.
        * `auth_state.dart`: Định nghĩa các class mô tả các trạng thái khác nhau của quá trình xác thực (ví dụ: `AuthLoading`, `AuthSuccess`).

* ### `lib/utils/`
    * **Chức năng:** Chứa các file tiện ích chung, hằng số cấu hình và các định nghĩa toàn cục cho ứng dụng.
        * `theme.dart`: Định nghĩa bảng màu, kiểu chữ và các thuộc tính giao diện (ThemeData) của ứng dụng.
        * `app_routes.dart`: Chứa các định nghĩa về tên đường dẫn (route names) để điều hướng giữa các màn hình.
        * `api_constants.dart`: Lưu trữ các hằng số liên quan đến cấu hình API (URL cơ sở, endpoints, v.v.).
        * `error/failures.dart`: Định nghĩa các class lỗi tùy chỉnh (ví dụ: `ServerFailure`, `NetworkFailure`) để xử lý lỗi một cách có cấu trúc.

* ### `lib/widgets/`
    * **Chức năng:** (Hiện tại chưa có nhiều) Dành cho các widget Flutter nhỏ, có thể tái sử dụng trên nhiều màn hình để tránh trùng lặp code.

* ### `lib/data/`
    * **Chức năng:** (Hiện tại trống) Có thể dùng để chứa dữ liệu mẫu (mock data) hoặc các tài nguyên dữ liệu cục bộ khác.

## 🛠️ Công nghệ sử dụng

* **Flutter:** Framework phát triển UI
* **Provider:** Quản lý trạng thái
* **GetIt:** Dependency Injection
* **Dio:** HTTP Client
* **shared_preferences:** Lưu trữ dữ liệu cục bộ
* **equatable:** Giúp so sánh các đối tượng dễ dàng
* ... và các package tiêu chuẩn khác của Flutter.

## 🚀 Cài đặt và Chạy ứng dụng

1.  **Clone repository:**
    ```bash
    git clone [URL_REPOSITORY_CỦA_BẠN]
    cd safetrek_app
    ```
2.  **Tải các dependency:**
    ```bash
    flutter pub get
    ```
3.  **Chạy ứng dụng:**
    ```bash
    flutter run
    ```

---