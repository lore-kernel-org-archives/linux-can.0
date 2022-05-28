Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B722C433F5
	for <linux-can@archiver.kernel.org>; Sat, 28 May 2022 15:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbiE1PyJ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 28 May 2022 11:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbiE1PyJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 28 May 2022 11:54:09 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337CF15818
        for <linux-can@vger.kernel.org>; Sat, 28 May 2022 08:54:07 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id g11-20020a056e021e0b00b002d1b5e8389bso4957997ila.2
        for <linux-can@vger.kernel.org>; Sat, 28 May 2022 08:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YBWhcnEjzHwhtIpcyV3G+n8eZtSERP7GIZTa1mABrIQ=;
        b=oxmjSM+jtyhXx4yYs0slTXNOZtBgo1pI0gKnvxM6XAEyAzirq9NKH9ShwqeLjL1sl9
         ai05bKAhcG7vrWBELpZJnexBFXe4h7zmo9qTLZ74hpx2qsc4IEG1lTghfDou8sGEGVbz
         AA32rimbukA3c6FGMjBIviy4giJIKRY03T89e7eKhu89V9x/yaDr0Qgr+gJ9IOTP/Nbr
         u7VN5LIUf+tZA57G2V9vbZvwg4ZKv2VGZwPlNDF/SASfkjlJ/5BCEto5+l3NGdncHkNu
         TYeKDoPeiWKewN7iqNquK7q9TuLt07NKJbOzSDVHu5l0e+ny/77Uu/l7TXsDrIXDA1qF
         YxXw==
X-Gm-Message-State: AOAM532y0a/eCxubLyvFNhgm5/W8OOkFF+15IL/JhlsWJ7Pp3A4p4/I+
        PXj4jXqGCJrA3o7Y458c+uuzLDLZDE1HpRB0gXiSAgLGyIsE
X-Google-Smtp-Source: ABdhPJwTNKsZOz0VuH2CDi/nZXLiPnNA99ONMHbUdPNx2ZnXvdt0LIAdyw5/ox49nfzscenMJtLWAbvHVF4r+11UKgpGAIDqxHkP
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1350:b0:331:9b1:e917 with SMTP id
 u16-20020a056638135000b0033109b1e917mr1334598jad.131.1653753246569; Sat, 28
 May 2022 08:54:06 -0700 (PDT)
Date:   Sat, 28 May 2022 08:54:06 -0700
In-Reply-To: <000000000000ae0adf05db4b6f66@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cee18105e0146e2d@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in j1939_xtp_rx_dat_one (3)
From:   syzbot <syzbot+a9dce1ff45c3bbeceb3a@syzkaller.appspotmail.com>
To:     davem@davemloft.net, elver@google.com, hdanton@sina.com,
        john.ogness@linutronix.de, kernel@pengutronix.de, kuba@kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
        pabeni@redhat.com, pmladek@suse.com, robin@protonic.nl,
        rostedt@goodmis.org, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 701850dc0c31bfadf75a0a74af7d2c97859945ec
Author: Marco Elver <elver@google.com>
Date:   Tue May 3 07:38:44 2022 +0000

    printk, tracing: fix console tracepoint

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=153df725f00000
start commit:   ae085d7f9365 mm: kfence: fix missing objcg housekeeping fo..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bae4cd50262530e
dashboard link: https://syzkaller.appspot.com/bug?extid=a9dce1ff45c3bbeceb3a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12529653700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b64ea5700000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: printk, tracing: fix console tracepoint

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
