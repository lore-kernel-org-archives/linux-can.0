From: Hubert Denkmair <xor@xor.wtf>
Subject: socketcan and libnl3
Date: Sun, 22 May 2016 12:17:31 +0200
Message-ID: <5741873B.5040300@xor.wtf>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.xor.wtf ([46.38.236.187]:41480 "EHLO mail.xor.wtf"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180AbcEVK4k (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 22 May 2016 06:56:40 -0400
Received: from p200300d113c70f00f4d2d0dcc818741f.dip0.t-ipconnect.de ([2003:d1:13c7:f00:f4d2:d0dc:c818:741f])
	by mail.xor.wtf with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.84_2)
	(envelope-from <xor@xor.wtf>)
	id 1b4QRv-0005WN-7F
	for linux-can@vger.kernel.org; Sun, 22 May 2016 12:17:31 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi there,

is anyone here using libnl3 to configure socketcan links?

I'm running into trouble and I'm wondering whether it's just me or if the 
rtnl_link_can_set_ctrlmode() and rtnl_link_can_set_restart_ms()
calls should work at all?

So, setting bitrate and sample-point via libnl works for me,
setting e.g. CAN_CTRLMODE_LISTENONLY does not.
Setting modes via iproute2 works as expected.

My code is here:
https://raw.githubusercontent.com/HubertD/cangaroo/master/canifconfig/main.c
(will gladly boil that down to a few lines if anyone is interested...)

Greetings,

Hubert
