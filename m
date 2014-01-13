From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: slcanpty: incomplete command handling
Date: Mon, 13 Jan 2014 11:17:35 +0100
Message-ID: <CAGm1_ksrM92ykD5DfF1XcmUSDKn593aMG=Md=2B8ngcrXLugzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:43239 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbaAMKR4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 05:17:56 -0500
Received: by mail-bk0-f54.google.com with SMTP id u14so709966bkz.27
        for <linux-can@vger.kernel.org>; Mon, 13 Jan 2014 02:17:55 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Shouldn't the char buf[100] in pty2can() be declared as *static* to
hold previous incomplete command? Otherwise it is just a local
variable?

Yegor
