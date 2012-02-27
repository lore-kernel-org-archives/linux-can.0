From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: SocketCAN support in Android
Date: Mon, 27 Feb 2012 10:26:31 +0100
Message-ID: <4F4B4C47.4060601@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from hhlx01.visionsystems.de ([62.145.30.242]:54547 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab2B0J0o (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 27 Feb 2012 04:26:44 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>

I'm working with TI's am3517. The next generation 33xx is also on the way. Considering lot's of requests about SpcketCAN support in Android on various mailing lists and forums I wanted to summarize how I see this situation:

1. ip from iproute2. Android version prior 4.0 provided only tc utility from iproute2 and due to header issues in NDK there were no easy way to get ip compiled. Ice Cream Sandwich introduced ip support, but ip/iplink_can.c symbols are missing in final ip binary, so it is not usable now. I tried to figure out what's wrong, but failed, so any help would be appreciated.

2. NDK: can.h is still not a part of NDK's headers, so for now can.h must be supplied to compile can-utils and user software. As one can see from this post: https://groups.google.com/d/topic/android-ndk/K1w5IqGSKCA/discussion NDK dev's don't seem to accept CAN as standard kernel protocol. Lobby work needed ;-)

3. As soon as there is solution for both issues, Java wrapper will be needed to enable App development

What do you think about this?

Best regards,
Yegor
