Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20149C4338F
	for <linux-can@archiver.kernel.org>; Sun, 25 Jul 2021 07:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E938960F11
	for <linux-can@archiver.kernel.org>; Sun, 25 Jul 2021 07:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhGYHCc (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sun, 25 Jul 2021 03:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhGYHCb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Jul 2021 03:02:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A69BC061757
        for <linux-can@vger.kernel.org>; Sun, 25 Jul 2021 00:43:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id f13so4484701edq.13
        for <linux-can@vger.kernel.org>; Sun, 25 Jul 2021 00:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6b3gaCahbgQn74mkPvOHGp3JJS44ejlXhR3AO5OG470=;
        b=DsZlkuVu07mtr2OJGvd/HGkGKi0+z4Qeey5nICDc1pCzS0jeqjmprSPA6rr8JTJYXp
         XHp6+iivoQEAQ+JKgAOmJ0pp6sLiPdYXxhS9k52juMzpEZ6wG4Om+dY1fHSCAETrD8o0
         pctIaa+oPGlvKsxX0XONGJ03WZE11vVJWUPb71Dmva9IJoTKHLhJLHHx+GVHyn2JEy2s
         OfRmpjE7oCSiXXjkihaPIv8K9oxqRkOVjUBzgrlEPRQVLGuVuD0XKItzVUZxQRH3nYyI
         8WLhloPHuFkyYw+TAq7YsS2aLlEH5wPVtm7wqIEhC++8laf22gkxQVHpMvIPilUDPVhz
         n55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6b3gaCahbgQn74mkPvOHGp3JJS44ejlXhR3AO5OG470=;
        b=MQhsLN+cgydjYExPkg7NiwbME51b5SNbkNXPgmnjCYmOy3xerJF6/jjmrocxMSrI+T
         H3ovaZjWGOMCbAImLpTMs/RsHzpaxtjW3DF0FqqpDcqK1jmdVdbQjaz6ZxlzHKo3PUsS
         0CXAnBo8pXxPuC4B+1QxJf2jza+jy31CTj5+4vGlHQNX6gBqtSjZAznFFO2pn9oo56Ht
         00R18zgUdSxss+mOO8lv5DxKylvxDnLWbmd9iTxfXIi8oCODPWoaN45JZt1cnRF7XL9/
         dTTDmalnTHYSlZw+xkPRXKYHf3hK2PWXo8pz5oNfkvD1gk6C3dcZmyeB+DG5yyVBnlOw
         amXA==
X-Gm-Message-State: AOAM531pjuA7S18W4wk1vjvWbMc6IpozOEk5+Ahlgc/iNF0O3+iI4gKq
        2pi+ybRojfYOD4zeeBbKeHCu7EOy861JWjxSl5M=
X-Google-Smtp-Source: ABdhPJweDPxt+pu/lggIPrZH8Bsn62POi2o0n87CHX7vy0bdcGuZOjVaanyHrava/xccmZqrDhm+nLMgPTkWBBvdDdw=
X-Received: by 2002:a05:6402:2206:: with SMTP id cq6mr15018822edb.209.1627198980828;
 Sun, 25 Jul 2021 00:43:00 -0700 (PDT)
MIME-Version: 1.0
From:   Yasushi SHOJI <yasushi.shoji@gmail.com>
Date:   Sun, 25 Jul 2021 16:42:49 +0900
Message-ID: <CAELBRW+6BGDPaUGrTDJtv020zF1AvtBAy2Jb1+i=uDbcH+0SzA@mail.gmail.com>
Subject: Re: [PATCH] can: mcba_usb: fix memory leak in mcba_usb
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Pavel,

Apologize for the late reply.

Since 6bd3d80d1f019cef, my Microchip CAN Analyzer stopped working,
more precisely I can't capture any data with it and repeated messages
from the driver flod the syslog. I usually use the Debian kernel image
and linux 5.10.46-2 migrated to unstable on July 20th.  I noticed my
device stopped working a few days later but didn't have time to
bisect.

Does your device work with the patch?
Does the patch work on the main line?

I've posted some report with my hardware configuration at debian mailing list:
https://bugs.debian.org/990850

Please let me know if you need any more information.

Best,
--
               yashi
