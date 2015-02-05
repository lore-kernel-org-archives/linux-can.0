From: Stefan Tatschner <stefan@sevenbyte.org>
Subject: [PATCH] can-doc: Fixed a wrong filepath in can.txt
Date: Thu,  5 Feb 2015 15:33:24 +0100
Message-ID: <1423146804-8530-1-git-send-email-stefan@sevenbyte.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-can@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Tatschner <stefan@sevenbyte.org>
List-Id: linux-can.vger.kernel.org

Signed-off-by: Stefan Tatschner <stefan@sevenbyte.org>
---
 Documentation/networking/can.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
index 2236d6d..0a2859a 100644
--- a/Documentation/networking/can.txt
+++ b/Documentation/networking/can.txt
@@ -234,7 +234,7 @@ solution for a couple of reasons:
   mechanisms. Inside this filter definition the (interested) type of
   errors may be selected. The reception of error messages is disabled
   by default. The format of the CAN error message frame is briefly
-  described in the Linux header file "include/linux/can/error.h".
+  described in the Linux header file "include/uapi/linux/can/error.h".
 
 4. How to use SocketCAN
 ------------------------
-- 
2.2.2
