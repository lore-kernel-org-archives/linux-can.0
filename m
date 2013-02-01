From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: can-utils: usage with kernels prior to 3.6
Date: Fri, 1 Feb 2013 08:30:44 +0100
Message-ID: <CAGm1_kvzT8e7_7JNt6NUyHUccpFb0c9v8XP3RStOWw6uKhObtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:33921 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab3BAHbG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 1 Feb 2013 02:31:06 -0500
Received: by mail-bk0-f42.google.com with SMTP id jk7so1705297bkc.15
        for <linux-can@vger.kernel.org>; Thu, 31 Jan 2013 23:31:04 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I've looked at the source code of the latest can-utils and it seems
like one cannot use them with the kernels prior to 3.6 because of
missing CAN FD support. The "struct can_frame" was replaced with the
new one, so that candump, cangen etc. are using only the CAN FD frame
structure.

Am I missing something?

Yegor
