From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: slcanpty with TCP support
Date: Fri, 26 Jul 2013 14:03:40 +0200
Message-ID: <CAGm1_ksXz6yoMRvdQwroyYV=UG2raKqfii_7aL++a94w_6_S+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:46864 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab3GZMEC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 26 Jul 2013 08:04:02 -0400
Received: by mail-bk0-f47.google.com with SMTP id jg1so1095979bkc.34
        for <linux-can@vger.kernel.org>; Fri, 26 Jul 2013 05:04:00 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

To continue this discussion
(http://comments.gmane.org/gmane.linux.can/3540). What about adding
TCP support for slcanpty? Otherwise one must have to use socat, so
that 2 services are involved. I'd like to avoid his.

Yegor
