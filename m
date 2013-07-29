From: yegorslists@googlemail.com
Subject: slcanpty and TCP
Date: Mon, 29 Jul 2013 11:37:56 +0200
Message-ID: <1375090677-4758-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:55601 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918Ab3G2JiX (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 29 Jul 2013 05:38:23 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, socketcan@hartkopp.net

This is a first quick and dirty patch for including TCP support. 
There some questions to clear. The firs one is, what to do with ENOBUFS
(http://dics.voicecontrol.ro/process_mails/arata_discutia/173374/[PATCH]_candump:_add_option_to_ignore_ENOBUFS.html)?

What about providing LAN interface name or none for expicit binding?

Yegor
