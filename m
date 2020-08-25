Return-Path: <SRS0=GUJ3=CD=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B33BC433E1
	for <linux-can@archiver.kernel.org>; Tue, 25 Aug 2020 02:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C1F20639
	for <linux-can@archiver.kernel.org>; Tue, 25 Aug 2020 02:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598321924;
	bh=kvFlO2FOmQ/MwVjeEiK/0zrFjoRu+RGPoo+Wwy2QLmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ey8aiKg1+/rnSI6r+z54pAn2qXosRUymsIFtmhiW1LQYe0IGbWtIfIT05Wa6Z5iR1
	 TR5u5YKJJtDm+KMu/dJngZL3M6pS5qorRLxnCHkBhEI9YxHztGMKGPZI0IKROMCadr
	 vzzp110hbg1sb2n8wILSCSEdpO/yMM9HdREKf5Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgHYCSi (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:18:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32846 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgHYCSh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 24 Aug 2020 22:18:37 -0400
Received: by mail-io1-f67.google.com with SMTP id g14so10927161iom.0;
        Mon, 24 Aug 2020 19:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PaCm4RFqZUlgz+BQfDBY/KJ2fozYLkl5ReDvv2n1CMg=;
        b=NVbD+zRG1/lBM8Nms85ogru6L3D6s/2YET3rL1dq9GjuovH8mHvFxUOQijP7etHhpk
         ZLEFwUHftTEowI1X+uQd+IKEG66Yn8XeO0EAPHpjQva2SnKengwFnL+G568AuIujHZu8
         kKBcOl/k1RDd1sNuk3XwjFxDbRxkAUEgiwazf026Vkb9DzvechYYdZZHP5OXitDSkCQH
         rY9+As2B/RbtOjIEFFOWVRIc+oCb4FOfNrH89fVOMMpK1hP0LF0y7Fqtd72C6qOMIWgt
         AQG03jz/AdeGflXbq4Azic4qJKiOeH3KG/mS8hAkItC3N4cjdRCCR6bOf4OjdwLiVUNY
         41TA==
X-Gm-Message-State: AOAM530RFU1ll1kYutP3E5E6PeoAg4bENkEHxZ1oeDtsMs0lTKFCJUeE
        j/QHPqcDDKKBcgYk+eeewg==
X-Google-Smtp-Source: ABdhPJxST48RHyJ7FDYKtbZvF/5Qj4RSCj8Rt38MqPRlmGd41H2AMpaY38aHYqSdlQJGYowHsylPzQ==
X-Received: by 2002:a6b:f919:: with SMTP id j25mr7505426iog.113.1598321916430;
        Mon, 24 Aug 2020 19:18:36 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id q1sm7548484ioh.0.2020.08.24.19.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:18:35 -0700 (PDT)
Received: (nullmailer pid 3804065 invoked by uid 1000);
        Tue, 25 Aug 2020 02:18:34 -0000
Date:   Mon, 24 Aug 2020 20:18:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>,
        David Miller <davem@davemloft.net>, mark.rutland@arm.com,
        Carsten Emde <c.emde@osadl.org>, armbru@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marin Jerabek <martin.jerabek01@gmail.com>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Jiri Novak <jnovak@fel.cvut.cz>,
        Jaroslav Beran <jara.beran@gmail.com>,
        Petr Porazil <porazil@pikron.com>
Subject: Re: [PATCH v5 2/6] dt-bindings: net: can: binding for CTU CAN FD
 open-source IP core.
Message-ID: <20200825021834.GA3801719@bogus>
References: <cover.1597518433.git.ppisa@pikron.com>
 <4ad7279ba263bb4da35edcefc66679a9d72702ec.1597518433.git.ppisa@pikron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ad7279ba263bb4da35edcefc66679a9d72702ec.1597518433.git.ppisa@pikron.com>
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat, Aug 15, 2020 at 09:43:04PM +0200, Pavel Pisa wrote:
> The device-tree bindings for open-source/open-hardware CAN FD IP core
> designed at the Czech Technical University in Prague.
> 
> CTU CAN FD IP core and other CTU CAN bus related projects
> listing and documentation page
> 
>    http://canbus.pages.fel.cvut.cz/
> 
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>  .../bindings/net/can/ctu,ctucanfd.yaml        | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml b/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml
> new file mode 100644
> index 000000000000..6fa42112bb58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license please:

(GPL-2.0-only OR BSD-2-Clause)

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/ctu,ctucanfd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: CTU CAN FD Open-source IP Core Device Tree Bindings
> +
> +description: |
> +  Open-source CAN FD IP core developed at the Czech Technical University in Prague
> +
> +  The core sources and documentation on project page
> +    [1] sources : https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core
> +    [2] datasheet : https://canbus.pages.fel.cvut.cz/ctucanfd_ip_core/Progdokum.pdf
> +
> +  Integration in Xilinx Zynq SoC based system together with
> +  OpenCores SJA1000 compatible controllers
> +    [3] project : https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top
> +  Martin Jerabek dimploma thesis with integration and testing
> +  framework description
> +    [4] PDF : https://dspace.cvut.cz/bitstream/handle/10467/80366/F3-DP-2019-Jerabek-Martin-Jerabek-thesis-2019-canfd.pdf
> +
> +maintainers:
> +  - Pavel Pisa <pisa@cmp.felk.cvut.cz>
> +  - Ondrej Ille <ondrej.ille@gmail.com>
> +  - Martin Jerabek <martin.jerabek01@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: ctu,ctucanfd-2
> +          - const: ctu,ctucanfd
> +      - const: ctu,ctucanfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description: |
> +      phandle of reference clock (100 MHz is appropriate
> +      for FPGA implementation on Zynq-7000 system).
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ctu_can_fd_0: can@43c30000 {
> +      compatible = "ctu,ctucanfd";
> +      interrupts = <0 30 4>;
> +      clocks = <&clkc 15>;
> +      reg = <0x43c30000 0x10000>;
> +    };
> -- 
> 2.20.1
> 
