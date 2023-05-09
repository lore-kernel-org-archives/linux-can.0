Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02D4C7EE22
	for <linux-can@archiver.kernel.org>; Tue,  9 May 2023 08:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjEIIHz (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 9 May 2023 04:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbjEIIHk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 May 2023 04:07:40 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0B3106C7;
        Tue,  9 May 2023 01:07:01 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ab267e3528so39026595ad.0;
        Tue, 09 May 2023 01:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683619614; x=1686211614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40PV0VC+uLvo4YRnubUvGBAuoCKhqk9gddkp21ztTyw=;
        b=eIznOlKFcFPz+FEinUg41oZYF5abf+aeOD8p6eq5sq/EBK7FZfPtTVw6+4FGM5MKYM
         BhIGIywC7dXE6d+g6KnulFu4u99onmrY2nl2CyLXE6MQ5KVNu3Igo8MQUZ/9V0DMgbXE
         +PPLZPBbPCeBRUq7H9cFZOwhLHDsrBleYn8pz3fN+O5NrDQe09fF72DASUvDHne7KzsI
         uF9r2oKpjqWGtZn6vEpWMS7f4/8KYvIvLqmC/nNBXcJNZJ3/qSuibuIv9L+YY9KulMP/
         qq/KVWGRCdUemDTSKEdlCK+KUhiTH8okivk6fpjppOqAwuey4bsgfOG8vxOZFXc3mTi+
         IiKQ==
X-Gm-Message-State: AC+VfDyl6AyB9QFs2soULm4jSKswOaOc6b/ZdOcx6HjLYd78Plwd8fbU
        3TtJcPhzjT8TNcD0jX1btDwSpQ5csFE5domYpOI=
X-Google-Smtp-Source: ACHHUZ5Y+vYnuLr8wBa6PI3ZwpqB724BhdZjdYM8a1RY54pVUhBYOam44+pOyn8tzox9nN+T9rcw9si5zYh4kn21yNo=
X-Received: by 2002:a17:902:da89:b0:1a2:37fc:b591 with SMTP id
 j9-20020a170902da8900b001a237fcb591mr15463598plx.69.1683619614305; Tue, 09
 May 2023 01:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230507155506.3179711-1-mailhol.vincent@wanadoo.fr>
 <20230508-sprint-cause-80b4172d5a5a-mkl@pengutronix.de> <CAMZ6RqKQw702HPjBTNJdBfL8yhkn5vDVDfn6dbrVMv7SX6NO2w@mail.gmail.com>
 <BL3PR11MB64841417866BA13DFEA3E373FB769@BL3PR11MB6484.namprd11.prod.outlook.com>
In-Reply-To: <BL3PR11MB64841417866BA13DFEA3E373FB769@BL3PR11MB6484.namprd11.prod.outlook.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 9 May 2023 17:06:43 +0900
Message-ID: <CAMZ6Rq+DW7Vdrjb+T2FVkh4iCFAGWQSUTpCAuFCsH_TJ-NYjTg@mail.gmail.com>
Subject: Re: [PATCH] can: length: add definitions for frame lengths in bits
To:     Thomas.Kopp@microchip.com
Cc:     mkl@pengutronix.de, linux-can@vger.kernel.org, marex@denx.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Thomas,

On Mon. 9 May 2023 at 16:12, <Thomas.Kopp@microchip.com> wrote:

[...]

> Right, do you plan on separating this for Arbitration bitrate and databitrate? It would probably make sense to use a fixed number of worst case stuffbits for the arbitration phase and the formula for the data phase.

I have a few ideas how to implement it, but seeing how complex things
are going, I am thinking of creating an inline helper function for the
bitstuffing calculation (the compiler should be able to fold it into a
constant expression, so there should be no penalty).

For the exact details, I have not decided yet. I need to experiment.
This not being so trivial and not having so much free time now, please
wait a few days for the v2 ;)
