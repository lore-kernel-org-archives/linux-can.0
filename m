Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7180EC433F5
	for <linux-can@archiver.kernel.org>; Tue, 22 Feb 2022 14:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiBVOWP (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 22 Feb 2022 09:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiBVOWP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 09:22:15 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657D6B6D0E
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 06:21:49 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id q1so7170410plx.4
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 06:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=0/ZOJKw8Vd9t7Z6nB+WnQTzkOyYM9o+BYy3iRhxBz9A=;
        b=okw/DsAoNs2EV7CZpC9rpnGG28iyAPGf5DbAEWj3MvjSCTBPu2nyiE51Ll57YrE2f6
         Zq6dOdfpm8v+6n3lt4M9Rifm8NfYTDYiACqTD4GOY8yFanDsTi+AUcUqHf1ubOIPhzyp
         teo8iOohIk5kIc+VmLGIvzLm4HJi/Z0h0atKYIl13jSUh6C6tNEfnVHkETye5GaybdeE
         U4TiNFX2LZYiplNAfmCoLY3kwRgDhznYX44XNpdOv2rO0OM96s5MXHgDl74KV0/5TUcE
         8xRqP6YcVsEOLXHsVcZp0kX4iig31sKvkwxF7Qy1Y2OGamx+BosffdfAzYnoxFalF873
         0K9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0/ZOJKw8Vd9t7Z6nB+WnQTzkOyYM9o+BYy3iRhxBz9A=;
        b=hFgm0S6vbMR4VGdUSc3clk5Ec5HSWtozsWzgaun5leAvAi4g4R5UPS59AMlFf8JOaZ
         ALeDp68oNlKNXAshPcdg3kLsGkOUBEox3P8x2exIJRWwLt6nA1LdFPe1Lslst1bf0OZO
         UtG9Xzpr75qEObbh6EchRnIp2sOsczTHyVr/Xc7MzFTqerCN0q1RX8Ig1eI5SFip/TUi
         w/WlJeK8HVoQ2QZzVtkOp4R31rNWiLDnRqxBGFlyY4SgNwmDiAB8Wl/PXF+WfJuVaKBS
         b4gxV7kZh/0IMmob+litRdLztaI33/tF85ffMFK7cqjOQ1hVaxbaNoSMcwWnUOaG1jUT
         r4/g==
X-Gm-Message-State: AOAM532n4YbuMTDmD98pyV6NUP9SkM37oP32VRnGaStC1GcBp50qiOQW
        CcUYbyKo9IzGAYhxv9UrPxuTuPKY296rInDiFltNsLMiqdTlDIVU
X-Google-Smtp-Source: ABdhPJx+9zMO8Z9WrsOpShZxql8JVcSxhi84SWoHRN6QaNsZU1DOdfTktQ7abdZfwvEUSdHEzSc2kFehIgYjxZQDVjw=
X-Received: by 2002:a17:90a:6688:b0:1bc:5492:6373 with SMTP id
 m8-20020a17090a668800b001bc54926373mr4341482pjj.161.1645539708441; Tue, 22
 Feb 2022 06:21:48 -0800 (PST)
MIME-Version: 1.0
From:   Matheus Eduardo Garbelini <mgarbelix@gmail.com>
Date:   Tue, 22 Feb 2022 22:21:36 +0800
Message-ID: <CANsTw8pbmOcHecJ-aVBhN6gHmmYmTVPOun0BqgfktZ=CyWGzOA@mail.gmail.com>
Subject: Looking for CAN FD sample captures for socket-can hardware
 integration testing
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Dear all,

I'm not sure if this is the right place to ask this,
but I'm looking for some sample CAN FD captures to test different
socketcan configurations in a real testbed.
There is a lot of CAN FD hardware already available, but I could not
find on the web any FD sample capture on the matter.
Would appreciate it if anyone could share or point me to the direction
on where to find CAN FD sample databases as reference for socketcan
testing and FD frame simulation.

Regards,
Matheus Garbelini
