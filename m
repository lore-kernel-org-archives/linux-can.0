From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: slcan2d
Date: Thu, 11 Jul 2013 10:38:44 +0200
Message-ID: <CAGm1_kt9Pd_JjfBJSWMHMJaq3eyKE2LpBjk5323Waksz1vQYPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:44909 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755746Ab3GKIjG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Jul 2013 04:39:06 -0400
Received: by mail-bk0-f42.google.com with SMTP id jk13so3271759bkc.29
        for <linux-can@vger.kernel.org>; Thu, 11 Jul 2013 01:39:04 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Trying to commit slcan2d.c
(https://github.com/yegorich/can-utils/commits/slcan2d) and my git
1.7.7 renames slcand.c because it looks quite similar. How can I
prevent this? So far I found no option for git commit command.

Yegor
