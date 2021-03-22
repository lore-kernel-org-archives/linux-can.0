Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4A2C433C1
	for <linux-can@archiver.kernel.org>; Mon, 22 Mar 2021 08:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540366196E
	for <linux-can@archiver.kernel.org>; Mon, 22 Mar 2021 08:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCVIdH (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 22 Mar 2021 04:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhCVIcr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Mar 2021 04:32:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3113C061574
        for <linux-can@vger.kernel.org>; Mon, 22 Mar 2021 01:32:46 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x21so18215576eds.4
        for <linux-can@vger.kernel.org>; Mon, 22 Mar 2021 01:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8FvBM2oWd+FCyV4C/gnTu6HqNKF162jkU776/Z4CW2E=;
        b=FZT6zawKqsLdDQ1I32LGTLG67CtBN/g9fM9D50svIcpQNwupj0UtBvdKHMyil7ZKs4
         nrmMwp71L42zUmOI6awyqSF4iS8bO4mtEMNR/6acvO75xJb1/krQ9vwU3jVTI8UQFJgp
         dYm0wkRFOU05uHIwwKOn/5PO9AZC1HLp1V4mgLs61ywFS/BWwwZqXU7Ci8vXMIc6Tgkr
         po+SIsUloRcwcJv60oScrxsUi3FowuSsmquIxA251HYeILqabChT+HVEKGN9ctsRo2Mh
         KgJVdC2MdAItM3k0TzkQUYQCVkgyzAhweUpyYTdVaPBS5GwZNW8mGqIRc76NZ50F8n28
         oVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8FvBM2oWd+FCyV4C/gnTu6HqNKF162jkU776/Z4CW2E=;
        b=TQt8ZRyh0vDcvqETDMP/1+yQxhbkheIycBDllqooE9hnYrtYwzlACQU/dd9Vtfpnk0
         Xa2migINpundvI3p2EgyUIXguXbyzzfVU86Qz6cXYP8fFtP5Z4Dzox3oytbTRQdwrZAh
         3k2G+HDZSmgIB5a8YVoibRT0AEWmwun+aBF1pxLdmYeqtKzDbM/o8Ocoj21vGKTMWWr9
         qMUcor8yxqy5Q+k5KIWf6Igot1X985zHKOzb8J2Daw3ikpXMB9YoGvWrqJBhu66PSWCf
         3kjDRb6/U5PxyU/V15Jb7hx/NKoo3A8BdHq2nloFlE+ZQDS1EnjKzHYxF4rgwgh+TZun
         TnGQ==
X-Gm-Message-State: AOAM533qcF2RB0if6pVnQ3lONkR3vObvSD6RGySd92tlGF3ry8S7udjw
        0iPlb7pHY5EVQsDQ0y/LcfT1yrGhhYfobHmDkiW94wTXptc=
X-Google-Smtp-Source: ABdhPJzKNLOVS0m5zH1p9kLjSpawLpluh63a27e/9lTJLtclA9wAePqHqhLeOHJMtLIL65IsDxy2AnTyr/jufyUo5Jk=
X-Received: by 2002:aa7:da46:: with SMTP id w6mr24638979eds.40.1616401965151;
 Mon, 22 Mar 2021 01:32:45 -0700 (PDT)
MIME-Version: 1.0
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Mon, 22 Mar 2021 09:31:16 +0100
Message-ID: <CAGm1_ksAVdckLEg+uMts6U9+=83PjesaSNjFojFPedeCsUCrUA@mail.gmail.com>
Subject: RFC: slcan: read status flags
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Is there any chance we could add 'F' command to get the error flags?
The problem is, there is no special interrupt or special packet coming
from the serial-to-CAN converter. So we cannot timely send this
information to the user. But perhaps an IOCTL could get the current
state?

What do you think?

Regards,
Yegor
