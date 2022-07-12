Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B50CCA482
	for <linux-can@archiver.kernel.org>; Tue, 12 Jul 2022 10:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiGLKTr (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 12 Jul 2022 06:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiGLKTo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 06:19:44 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15144ACF5D
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 03:19:43 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q7so9302284lji.12
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 03:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qQrOaDf50Pv0HOVBlT2lb+A0+1iMDwI1uAjsNNgoCyo=;
        b=KPJEVp/ed73HtOq/MVQ+p9kivU3u4M7wj69f+wN//6gnBqvYmbWeITVYEwD5KMjolQ
         ycJstb+7y3G/2uMcmwzvmCMQw8zLnf7UYjMpn0+LAZSGLl7mhI1qc+y26rvCDdUYWd+2
         8x25fLl0i/jbOLY4qZNmnW7PyMHJvZQDueGNnMQ9NocBNuoqAm9VWTdKXzhPowbek6dT
         x7oQtgKGrhjH/57rYjPNh+gSndWbQ1fWTWC2eR2RFiVLbMbVtOjcoH4G2hxo0lPgN2q5
         3Zg5ORogX/ojcwpvipHPSQK6THZucSkT0jPIrqnT0it7LPXN5kGey7hA6p9BTyVGibOS
         EToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qQrOaDf50Pv0HOVBlT2lb+A0+1iMDwI1uAjsNNgoCyo=;
        b=pGjjOdN9ZWADr5Nd2DoZggV7LAlJpdhR0rlSIMUICeSSWHjO+seR3XGyIS0F5Z3IlK
         bzsfUtfKvlrLEiP0Co0J6HFcigNhPy9kHK7hL3b8tNY1/F9J74N+y0u0w8Mbozy3vxEy
         5jAP3pdUb8Yyt9sHHhY2obLXYoA7024upM+9ZkSPFdESaxn0KXl14CpVYx4mM7Q3PaW3
         RZpFvb4jcByDnPWIThrdZ2kPB+CMSl0m8dVNHqlzhYl1TWOzpyQt9rmz0HXRNdAqZReY
         lXcMYw3QZhPHrlRr/V+zLCqxdsnGE5Jj+jEk1DSSAj+nj1LMP6zUlGBxLH5RJVYtOFdU
         gNaA==
X-Gm-Message-State: AJIora+059W4u7h0fYtQOljmgu8ESOv2FTR17hEt+Z48ALAh/bc3c9RV
        6CQ+2OYXgewG6JaEXPCvcdgyMA==
X-Google-Smtp-Source: AGRyM1vnr7d7f6KP0wTYXL4JCKV4WV74e9y1/USafXXWiDQ+8GgH8YDP/gg7p7Q1PxjrZeJ4fPijmQ==
X-Received: by 2002:a2e:81c1:0:b0:24b:f44:3970 with SMTP id s1-20020a2e81c1000000b0024b0f443970mr12330002ljg.97.1657621181447;
        Tue, 12 Jul 2022 03:19:41 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id i16-20020a056512319000b0047f9c1b1901sm2101709lfe.7.2022.07.12.03.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 03:19:40 -0700 (PDT)
Message-ID: <56774a8a-3f3b-3ba3-b57b-1fed5494b514@linaro.org>
Date:   Tue, 12 Jul 2022 12:19:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/6] dt-bindings: can: sja1000: Convert to json-schema
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20220710115248.190280-1-biju.das.jz@bp.renesas.com>
 <20220710115248.190280-2-biju.das.jz@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220710115248.190280-2-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 10/07/2022 13:52, Biju Das wrote:
> Convert the NXP SJA1000 CAN Controller Device Tree binding
> documentation to json-schema.
> 
> Update the example to match reality.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3->v4:
>  * Updated bindings as per coding style used in example-schema.
>  * Entire entry in properties compatible declared as enum. Also Descriptions
>    do not bring any information,so removed it from compatible description.
>  * Used decimal values in nxp,tx-output-mode enums.
>  * Fixed indentaions in example.
> v2->v3:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
