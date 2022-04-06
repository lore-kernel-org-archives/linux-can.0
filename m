Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D77C433F5
	for <linux-can@archiver.kernel.org>; Wed,  6 Apr 2022 18:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiDFSvG (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 6 Apr 2022 14:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiDFStC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 6 Apr 2022 14:49:02 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909CEE09BD;
        Wed,  6 Apr 2022 11:06:51 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id e4so3234690oif.2;
        Wed, 06 Apr 2022 11:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NV0lW1tSHUTbd+4Z35O+30iOwvDlNCjNcqdse63qw4c=;
        b=tyvk0NnWxSwbf8RsVozVF+Mu1fAs25XU0snXP/qjIEYSV8iT/g/Gl4oGnpsvMszAmG
         M8Gae1HcX8sXmPfAjqOYQHaydcMBSWwiZEKAn0WVj8Vr5HeQpLzOkaU3dNtFs97VBdut
         mCdM1kpmAtwS3fAtHbQACZuRoRCri8LnGq0EVWIWKcWJpxQPxlypXkJVGqcW3WBENB6Z
         NVYbSqmIuaaIlQIIvuxukNJSqNz2I8QZivLY8FN3oyfB7F9+4t2rKgPSGLwZ8RFgAfsN
         1M3DU8OokYphE3H50DA0ZsvtMvrIjLcbhpe9ZvfJU9agddtSR/HY8Dcl6OGd4CYKF1x1
         g+jA==
X-Gm-Message-State: AOAM53002WW/CKWlCLf2TTZndAma9WHyLLLBWhMhIhPFiZ+abWk1thdu
        uUTFdBcKX7yW2Py7uNbW3g==
X-Google-Smtp-Source: ABdhPJzNOlkk/pDqP+Kii3ZVVph5q9A1ktnfpQ3Hz1+9rtv+SrXNyeX4ngNYHtiW+gjcFE0OqFDRCw==
X-Received: by 2002:aca:1811:0:b0:2ef:3c0f:f169 with SMTP id h17-20020aca1811000000b002ef3c0ff169mr4206453oih.61.1649268410748;
        Wed, 06 Apr 2022 11:06:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q6-20020acaf206000000b002ef960f65b3sm6644127oih.25.2022.04.06.11.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:06:50 -0700 (PDT)
Received: (nullmailer pid 2512546 invoked by uid 1000);
        Wed, 06 Apr 2022 18:06:49 -0000
Date:   Wed, 6 Apr 2022 13:06:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2] dt-bindings: can: renesas,rcar-canfd: Document
 r8a77961 support
Message-ID: <Yk3WuULOeazcprrr@robh.at.kernel.org>
References: <20220404200930.1249612-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404200930.1249612-1-mkl@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, 04 Apr 2022 22:09:30 +0200, Marc Kleine-Budde wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> This patch adds documentation for the r8a77961 to the
> renesas,rcar-canfd binding.
> 
> Link: https://lore.kernel.org/all/20220401153743.77871-1-wsa+renesas@sang-engineering.com
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Changes since v1:
> - added patch description
> - added devicetree on Cc
> 
>  .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
