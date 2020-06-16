From: Arnej Duranovic <arnejduranovic@pm.me>
Subject: J1939: /proc/net/can interface
Date: Tue, 16 Jun 2020 18:40:49 +0000
Message-ID: <4SjA_8nFwOgutMJ5YoVaQPwX-zU-3shqgm7lsWxNWIQas0hIsCMdujJJbEJXOdxFjnDlDTqaDs4yiOXhAgZUYDUKIHXKcwtih3aa1fL8LV4=@pm.me>
Reply-To: Arnej Duranovic <arnejduranovic@pm.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-40131.protonmail.ch ([185.70.40.131]:16294 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgFPSlC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Jun 2020 14:41:02 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello all,

Earlier versions of J1939 contained the following:

+ 6. /proc/net/can-j1939 Interface.
+ --------------------------------
+
+   Files giving you a view on the in-kernel operation of J1939 are located=
 at:
+   /proc/net/j1939.
+
+ 6.1 /proc/net/can-j1939/ecu
+
+   This file gives an overview of the known ECU's to the kernel.
+   - iface : network interface they operate on.
+   - SA : current address.
+   - name : 64bit NAME
+   - flags : 'L' =3D local, 'R' =3D remote

I am interested in what happened to this feature since I do not see it in t=
he latest implementation or in the documentation?

I am interested in retrieving "known ECU's to the kernel" in the latest imp=
lementation. What is recommended?
