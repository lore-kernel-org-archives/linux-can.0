Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5890C7EE23
	for <linux-can@archiver.kernel.org>; Tue, 23 May 2023 09:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjEWJp3 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 23 May 2023 05:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbjEWJpX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 05:45:23 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44671B5
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:15 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2af2e908163so38095811fa.2
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684835054; x=1687427054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYiWmPCpnehnqjFpEC9L2V5fzJfQZyLMAcDgJ0aRcN4=;
        b=smvssXeeG9N0C5LurFuIJNmxaXbmNsf9imuUC+P+Y7e43wS2ISxGXYRsTDArEeOM00
         zAlEDPzD9/za51Cj2gkNMWVQuSiZALWuicqIi3bJKU1YwHZKI8zvBhcXDRwHJRjD4XCQ
         LzXnx7dlyH50QOx4kw+0xA5aM00eyRjmKOo94XNJfaD4WsEPTtO7ipH/ISeWeSA5y6jg
         TDjrOVtqFCxihsQmIXyPmTNZdSFXb5UbB/3pyQM5BqcLiKMDHab9b2jZEYnhIG2xaKjx
         nYy9hk62AV6mCugqeVEpgCpdN7y2AKGV2PAA6N9D+GwwlSpMm51kSKmVcE7ZVTHXZDdA
         r3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835054; x=1687427054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYiWmPCpnehnqjFpEC9L2V5fzJfQZyLMAcDgJ0aRcN4=;
        b=Za1ve+RpmdQh2EELlGS0wrzW27HFqdh8Sxb2WvUDuE6Bb+AtazvJcJFQ0jjr0ZY3T6
         aijPIEtrMHFnyuel7g8MWz/OXt4uhsVrYlBV0F6rxtcKhKY1NemPIstuuapFDGBDrs6V
         hfW1lF04Swp3b0moasfFZvPag/L5lvaBmyG7SW1dY38wsJbIcI152Zgo21Nab73o7xRr
         nIV3MY6yggbWggUgBSl6bvr1520fGPd3XAvr+tj/hJQhbq1xI3N8lRAs1Sf8HPgQMxm6
         FVGmyjPCwztm1Khq/w/u08oNT8ykVlDI3bvoxHiMKJWoRWcZ5/V1SFTdy2LeL6jfCloo
         6Agw==
X-Gm-Message-State: AC+VfDy8GJPsSV+Nibc6TIClqaWTvaokQFlWp7yKn0B7PRvc/G3UmRT8
        NC9A53wVOeSc0PJyIV7U9QSY2cr41uuVPXxejns=
X-Google-Smtp-Source: ACHHUZ6TZwxDsMg40JSU9Lt2b2UwMQ28xM+96dyvdHdOF2XFD8ox7z9BrZu6KqvasOUbQ6zJAmIs6Q==
X-Received: by 2002:a2e:b708:0:b0:2ad:bb53:8b9a with SMTP id j8-20020a2eb708000000b002adbb538b9amr4830268ljo.20.1684835054049;
        Tue, 23 May 2023 02:44:14 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9490000000b002ac87c15fd4sm1535551ljh.95.2023.05.23.02.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:44:13 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 0/3] can: kvaser_pciefd: Add support for new Kvaser PCI Express devices
Date:   Tue, 23 May 2023 11:43:51 +0200
Message-Id: <20230523094354.83792-14-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230523094354.83792-1-extja@kvaser.com>
References: <20230523094354.83792-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch series adds support for a range of new Kvaser PCI Express
devices based on the SmartFusion2 SoC, to the kvaser_pciefd driver.

In the first patch, the hardware specific constants and functions are
moved into a driver_data struct.

In the second patch, we add the new devices and their hardware specific
constants and functions.

In the last patch, most of the register reading and writing + shifting
and masking, are wrapped in macros, to simplify the functions.


Note: This series depends on the changes in xxx

Jimmy Assarsson (3):
  can: kvaser_pciefd: Move hardware specific constants and functions
    into a driver_data struct
  can: kvaser_pciefd: Add support for new Kvaser pciefd devices
  can: kvaser_pciefd: Wrap register read and writes with macros

 drivers/net/can/Kconfig         |   5 +
 drivers/net/can/kvaser_pciefd.c | 678 ++++++++++++++++++++++----------
 2 files changed, 479 insertions(+), 204 deletions(-)

-- 
2.40.0

