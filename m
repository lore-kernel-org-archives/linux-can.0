From: Armin Burchardt <armin@uni-bremen.de>
Subject: [PATCH v2 0/3] slcand: improved patches
Date: Tue,  9 Jun 2015 11:15:25 +0200
Message-ID: <1433841328-15581-1-git-send-email-armin@uni-bremen.de>
References: <1433764540-24917-1-git-send-email-armin@uni-bremen.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gabriel-3.zfn.uni-bremen.de ([134.102.50.3]:54225 "EHLO
	smtp.uni-bremen.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753637AbbFIJPf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 9 Jun 2015 05:15:35 -0400
Received: from schlemihl.intranet.nordsys.de (dmz.nordsys.de [85.220.134.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.uni-bremen.de (Postfix) with ESMTPSA id CD126120EEC
	for <linux-can@vger.kernel.org>; Tue,  9 Jun 2015 11:15:32 +0200 (CEST)
In-Reply-To: <1433764540-24917-1-git-send-email-armin@uni-bremen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

These patches contain changes requested on the list.
- coding style ( "} else {" ).
- default pidfile name "/run/slcand.pid". Generating a pidfile
  name based on the tty device name would require more effort, this
  could be done in a follow-up patch.
- name change of stream variable from pidfd to stream.

In addition:
- candev_setflags(): 'short' is used instead of '__u32'. This
  type is also used in the ioctl struct definition.

Armin (second time running 'git send-email' ever)

