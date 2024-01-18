

import 'package:tellesports/handlers/secure_handler.dart';

Future<Map<String, String>> rawDataHeader([String? token]) async {
  final accessToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMzlhYTBmZWVhMjY0ZGJiYzUxYjgwZmQ5M2QwNWJhYjM1OGI4ZTUwZWNiZmNjZGE3NTQ3YWU0MTdjYjYxN2U2ODU5MjM2NWJiNzllZThlMjAiLCJpYXQiOjE3MDU1ODAwMzguNDk0OTQ5LCJuYmYiOjE3MDU1ODAwMzguNDk0OTUxLCJleHAiOjE3MzcyMDI0MzguNDkxMTgxLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.V93_JFhKK9oCqY5eCBiiCS5WhdkP7XZjwFyBIHydAjgNs5KmkJPgCS4ZxA9Jp39NTa8rNsZgqxGiQ_w-NZly5uhM091iYGqW-O8YBq8yawvr2QmRXpL-hs73Cc6MoKD-X05MALDvWe_Ex6__xHicgG9QyIEVnPqRusL76SzNmIHWyCj2_HWqLhJpe5xzKFUUrrnc35ihmHilE4cwZJdcWXJdeEiHAI_l7VaknVaHEFLPMk0WyeOA3Z0SPPS02E4HphZHMtgoPhk0BV2LVB4K3zVV1271c3O-pDyC7kt3-K17_WQMbu8gq_Kb7eD9Nz_NU5mxxfM6PPfX4aN9zZ5wwUmkwNQfc7kZ0Jx_4mWpwBuD-kgi0zEkYoW26tJJW19KK5LC-jqvjSLB4tJfSGaNivoR9DgW6vR7sqJXsRVKNO_HRm9VU5yvfTx796S0cMJdEmZ-E-kRKIStm8Zq4gtsU8VIsyX19nD7_tP7nCtnDr8Am41X7uZzO3WYZBKhFRb6yE7rO50_5tg8f6j5WwgRUMI-vp99FbH1g45hh5Ulzw9BUicNcM4d0z7n0oqaHXP1328lLpdipdOsS7tqB9nXxPvNQCHzKQh634mkj3rLW5uLhbvd1r7lDaq5BUPk52BYCpi2Epk1-0TxqFjqO0mwNsODMpgctCEdMJ_Cjc1Ayy0';
  return {
    'Content-Type': 'application/json',
    if (accessToken != null) 'Authorization': accessToken,
  };
}

Future<Map<String, String>> formDataHeader([String? token]) async {

  final accessToken = await StorageHandler.getUserToken();
   
  return 
  
  
  {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
  };
}