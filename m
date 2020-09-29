Return-Path: <SRS0=rWFP=DG=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8B3C4727F
	for <linux-can@archiver.kernel.org>; Tue, 29 Sep 2020 09:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06C1A20848
	for <linux-can@archiver.kernel.org>; Tue, 29 Sep 2020 09:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgI2Jqr (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 29 Sep 2020 05:46:47 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34460 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgI2Jqp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 29 Sep 2020 05:46:45 -0400
Received: by mail-oi1-f195.google.com with SMTP id n2so4761369oij.1;
        Tue, 29 Sep 2020 02:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6oOOgapcFsJWSWWYMZP4dZW4BhIh9EKlk0wS9w12pg=;
        b=Udj0pdUpME7SVnKCDG2ulOB59g4WL+W6BOy09PUcuOzNzyYYkvh4b1awhLWsOSp7U1
         dZtrORDwuiYiTjaCMKbayqzDxCqPoouTutoVEx7EXXbzj15Sudz4poSzv6kyK/yFIzbR
         o0jVMVZdzb14L5xVIoKWIYnkKGHb2a+zRAEmJIWruectNWPeMR5mbM9tJTcJhtv/8glg
         Z8Pwa80CYtu+VhreqQJka+fNAzYLDybW7/CGXmjKHVfzFxbBug4TvX/b8tXikHu8FGoK
         HO3TF3IK4PM+jCZv8NGAxJ5UAo6nznlFHeXMAeAsVFa16FdyayfrxW/zcWCn54a1DjfT
         DGSQ==
X-Gm-Message-State: AOAM533T1DEzL0mP/DGRXaUrStfRc1kU/jDyX99fcMY+Yq90X/eAWLX7
        gl6b7RXYNEgrklP+e4+lyVyz0lpHyXJGdlhoCcCEcxNawB0=
X-Google-Smtp-Source: ABdhPJw69ARAmlJG/6Bkor+D8FVkFt/hrxObOfrwk39faTLjVzj+KTheJ5+4vSkT9LAzF9NPedcGkMZoQfBUpyJ3/ig=
X-Received: by 2002:aca:f203:: with SMTP id q3mr1874944oih.148.1601372803976;
 Tue, 29 Sep 2020 02:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200910133806.25077-1-manivannan.sadhasivam@linaro.org> <20200910133806.25077-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20200910133806.25077-3-manivannan.sadhasivam@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 29 Sep 2020 11:46:32 +0200
Message-ID: <CAMuHMdVkwGjr6dJuMyhQNqFoJqbh6Ec5V2b5LenCshwpM2SDsQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: can: mcp25xxfd: document device tree bindings
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-can@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dev.kurt@vandijck-laurijssen.be
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Manivannan, Oleksij,

On Thu, Sep 10, 2020 at 11:37 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> From: Oleksij Rempel <o.rempel@pengutronix.de>
>
> This patch adds the device-tree binding documentation for the Microchip
> MCP25xxFD SPI CAN controller family.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks for your patch, which is now commit 1b5a78e69c1fdae9
("dt-binding: can: mcp25xxfd: document device tree bindings") in net-next.

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/microchip,mcp25xxfd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title:
> +  Microchip MCP2517FD and MCP2518FD stand-alone CAN controller device tree
> +  bindings
> +
> +maintainers:
> +  - Marc Kleine-Budde <mkl@pengutronix.de>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: microchip,mcp2517fd
> +        description: for MCP2517FD
> +      - const: microchip,mcp2518fd
> +        description: for MCP2518FD
> +      - const: microchip,mcp25xxfd
> +        description: to autodetect chip variant

The last one is a wildcard?
When would you want to use it (oh, in the example below)?
Can you guarantee Microchip will not introduce other components that
match this wildcard, but are not compatible?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
