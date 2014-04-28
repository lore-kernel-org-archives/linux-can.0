From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: am335x: d_can: rx issue
Date: Mon, 28 Apr 2014 14:19:40 +0200
Message-ID: <CAGm1_ktbB6SOGd5PygOrh4FOZU1fofAK4omAur-VHeo1Tw9tJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:53150 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755734AbaD1MUA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Apr 2014 08:20:00 -0400
Received: by mail-pb0-f45.google.com with SMTP id rq2so854255pbb.18
        for <linux-can@vger.kernel.org>; Mon, 28 Apr 2014 05:20:00 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, tglx@linutronix.de

I'm testing 3.15.0-rc3-00006-gd497c20-dirty with latest commit:

Merge tag 'linux-can-fixes-for-3.15-20140401' of
git://gitorious.org/linux-can/linux-can

    linux-can-fixes-for-3.15-20140401

    Marc Kleine-Budde says:

    ====================
    this is a pull request of 16 patches for the 3.15 release cycle.

    Bjorn Van Tilt contributes a patch which fixes a memory leak in usb_8dev's
    usb_8dev_start_xmit()s error path. A patch by Robert Schwebel
fixes a typo in
    the can documentation. The remaining patches all target the c_can
driver. Two
    of them are by me; they add a missing netif_napi_del() and return value
    checking. Thomas Gleixner contributes 12 patches, which address several
    shortcomings in the driver like hardware initialisation,
concurrency, message
    ordering and poor performance.
    ====================

TX is working, but rx not. Am I missing any patches, that fix this issue?

Yegor
