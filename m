From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH 5/5 v2] slcand: add example scripts for udev/systemd
Date: Sat, 27 Dec 2014 13:10:10 -0800
Message-ID: <1419714610-8721-1-git-send-email-jmmahler@gmail.com>
References: <1419002540-2208-6-git-send-email-jmmahler@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:41037 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbaL0VKn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 27 Dec 2014 16:10:43 -0500
Received: by mail-pa0-f42.google.com with SMTP id et14so14976103pad.15
        for <linux-can@vger.kernel.org>; Sat, 27 Dec 2014 13:10:43 -0800 (PST)
In-Reply-To: <1419002540-2208-6-git-send-email-jmmahler@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>

The slcand daemon must be started after a serial CAN device is plugged
in to create the network interface (e.g. slcan0).  This can be done
manually but it is inconvenient.

Add example scripts for udev and systemd that can be used to start
slcand automatically when plugged in and to stop it when unplugged.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---

Notes:
    Placing these in etc/ allows them put in the same directory
    hierarchy where they would be normally installed.

 etc/systemd/system/slcand@.service | 11 +++++++++++
 etc/udev/rules.d/50-slcand.rules   | 16 ++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 etc/systemd/system/slcand@.service
 create mode 100644 etc/udev/rules.d/50-slcand.rules

diff --git a/etc/systemd/system/slcand@.service b/etc/systemd/system/slcand@.service
new file mode 100644
index 0000000..b823549
--- /dev/null
+++ b/etc/systemd/system/slcand@.service
@@ -0,0 +1,11 @@
+#
+# systemd/system/slcand@.service
+#
+
+[Unit]
+Description=Serial CAN daemon (can-utils)
+
+[Service]
+Type=forking
+ExecStart=/usr/bin/slcand -o -c -f -s6 %I
+#  %I is the device name from udev (e.g. ttyUSB0)
diff --git a/etc/udev/rules.d/50-slcand.rules b/etc/udev/rules.d/50-slcand.rules
new file mode 100644
index 0000000..bc96e55
--- /dev/null
+++ b/etc/udev/rules.d/50-slcand.rules
@@ -0,0 +1,16 @@
+#
+# udev/rules.d/50-slcand.rules
+#
+# When a LAWICEL LWX154GX serial CANUSB device is plugged in,
+# tell systemd to start the slcand (daemon) service.  When it
+# is un-plugged, stop the service.
+#
+# The $kernel argument to the slcand@.service is the
+# device name (e.g. ttyUSB0).
+#
+#   sudo systemctl status slcand@ttyUSB0
+#
+
+ACTION=="add", SUBSYSTEM=="tty", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="ffa8", TAG+="systemd", ENV{SYSTEMD_WANTS}="slcand@$kernel"
+
+ACTION=="remove", ENV{DEVNAME}=="/dev/ttyUSB?", ENV{ID_MODEL_ID}=="ffa8", ENV{ID_VENDOR_ID}=="0403", RUN+="/bin/systemctl stop slcand@$kernel"
-- 
2.1.4

