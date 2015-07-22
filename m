From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: can-utils: fix musl build issues
Date: Wed, 22 Jul 2015 20:59:26 +0200
Message-ID: <1437591568-19452-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38147 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbbGVS7t (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Jul 2015 14:59:49 -0400
Received: by wibxm9 with SMTP id xm9so116390928wib.1
        for <linux-can@vger.kernel.org>; Wed, 22 Jul 2015 11:59:48 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, mkl@pengutronix.de

These patches fix musl C library related build failures. See
http://autobuild.buildroot.net/results/0dd/0ddb5a70358bdbb491fbee670c7843c15217e78d/build-end.log
for build log.

Regards,
Yegor

