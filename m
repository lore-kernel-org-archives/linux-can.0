Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9D3ECAAD4
	for <linux-can@archiver.kernel.org>; Mon, 29 Aug 2022 19:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiH2TyZ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 29 Aug 2022 15:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiH2TyU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 Aug 2022 15:54:20 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390CF832D4;
        Mon, 29 Aug 2022 12:54:15 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 92-20020a9d0be5000000b0063946111607so6631402oth.10;
        Mon, 29 Aug 2022 12:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=lyPncyvzGMnHsn2NJD2Wx8+l/ZBBh2eY7zSwVmEoXhQ=;
        b=Kor4jSQu79bAvmMzEpyFc6ixpsCUvVvvoFr+49fJmwxqtkFZ0raZ1jN08EXmQ8CSdd
         EPiB36C/ynjJkW8FwMckLPxN+NrLx+kDgecPFbQg0XrzYwqf8DWnEjTsIFosv6kf/XHe
         MxU+GxA2LbcccvBJBG6byrr6xqBWMTUsx5xRhUbjM4DmRyziwGOOKFgkS9BwMNlGA++a
         pCzB7TXIpZYLsX01nq20QXPBEFA09j/AGFcayrt5KoqYonIk75lNVF3MmK05e3eEY8x/
         azZK7vxQ/TroOBGhN2wxsUE9hlkxXBv1sHWZUhqZFmY5JKdlpYFhZrCVdCg/Qb8IK2oo
         xTFg==
X-Gm-Message-State: ACgBeo0m4KrH4hKkwAH8erWZp1NDbeFlX5Bb1MKOslo33wEoLs1QoYTZ
        B+rxgD+J2OCvxhKNcc7FXgy0Br0c1Q==
X-Google-Smtp-Source: AA6agR6G5hd8fP2T9Gav0pJhipDiWl8T+BE4tQsy1a0XIeVRqP6SrT2YylqqpXl02qFIKmi+lgC6iA==
X-Received: by 2002:a9d:f43:0:b0:638:c3c4:73ee with SMTP id 61-20020a9d0f43000000b00638c3c473eemr6919760ott.186.1661802853800;
        Mon, 29 Aug 2022 12:54:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u41-20020a05687100a900b00118927e0dacsm6645582oaa.4.2022.08.29.12.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:54:13 -0700 (PDT)
Received: (nullmailer pid 2308225 invoked by uid 1000);
        Mon, 29 Aug 2022 19:54:12 -0000
Date:   Mon, 29 Aug 2022 14:54:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        netdev@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: can: nxp,sja1000: drop ref from
 reg-io-width
Message-ID: <20220829195412.GA2308173-robh@kernel.org>
References: <20220823101011.386970-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823101011.386970-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 23 Aug 2022 13:10:11 +0300, Krzysztof Kozlowski wrote:
> reg-io-width is a standard property, so no need for defining its type
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
