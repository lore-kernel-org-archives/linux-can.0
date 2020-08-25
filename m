Return-Path: <SRS0=GUJ3=CD=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487C6C433E1
	for <linux-can@archiver.kernel.org>; Tue, 25 Aug 2020 02:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B75620639
	for <linux-can@archiver.kernel.org>; Tue, 25 Aug 2020 02:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598321834;
	bh=WvVetekKhkaYtqbboq+rBKuO2wsH27S4WQusdkNNv0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FymBlJF4uE+TqG7Au0WlL1cjG9Os4iOkYpxp6hV3tDC/x/v7gIULv4dfOqol3pn68
	 S3llTrNbo99EQt3fdEaAnrpeg7wUfLA2Jxum1A6tAxqLadGQkegWACRFYTxLvdE5AV
	 g5JGBFxSXC9smMp6ev0+8MseE4qGlLwsWTY0Limw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgHYCRC (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:17:02 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:45914 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHYCRB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 24 Aug 2020 22:17:01 -0400
Received: by mail-il1-f193.google.com with SMTP id k4so9109246ilr.12;
        Mon, 24 Aug 2020 19:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cPaUYqeBD8duoMMFHhwQl/b6M7U9Dhl4gzL36hPNANM=;
        b=PaUg8UVgFkV8xgWBE6u2tLN0ov0OGgqUSMY5FL/6y8QNWzcgVS0RMLjXmSxw1VRE/9
         TZ1wuSpMryDW/TbNgREHclNA0kBCdo+0y3B2HjnS+YywKIYfryWG5jHbMIlUiFLzgUkc
         cidX65NgG3tkk/m0GKVGTHxYUIQp8uW6Z3ooSne5Mn8rL2187+OfO4E843ZVOJc2sqpN
         9a+e+TqsmWkHqDMISH8EcL5UIyWcnkCAihVXYrbMECV9KccJ7d3kbXmcg0/4ux/H03K8
         mqOBRDvZQQNg6B3TVSY2o+AKwFnOCG9pTKuC3dH2i8msr0pXn9AvqRBFZji+k9qwHt3G
         HW/Q==
X-Gm-Message-State: AOAM531QSZaVeghvCMUC85RaDFy6R+F3SEmQilBhFKnh2OKAmgD4jK0o
        Zvr4KNtxWuEFd/uuzuYf8jzD2wyBSUdH
X-Google-Smtp-Source: ABdhPJy039p/D5ALU5plBARNf/qhTGH6VaZe6QqtAV1pNqKKbjtJR47Z1aYdm+9EkRB8JTK6peL8tQ==
X-Received: by 2002:a92:5bcb:: with SMTP id c72mr6813468ilg.94.1598321820672;
        Mon, 24 Aug 2020 19:17:00 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id 18sm1263026iog.31.2020.08.24.19.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:17:00 -0700 (PDT)
Received: (nullmailer pid 3801477 invoked by uid 1000);
        Tue, 25 Aug 2020 02:16:57 -0000
Date:   Mon, 24 Aug 2020 20:16:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     devicetree@vger.kernel.org,
        Marin Jerabek <martin.jerabek01@gmail.com>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        David Miller <davem@davemloft.net>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, mark.rutland@arm.com,
        netdev@vger.kernel.org, armbru@redhat.com,
        Jiri Novak <jnovak@fel.cvut.cz>,
        Jaroslav Beran <jara.beran@gmail.com>,
        Petr Porazil <porazil@pikron.com>,
        Rob Herring <robh+dt@kernel.org>,
        Carsten Emde <c.emde@osadl.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: vendor-prefix: add prefix for the
 Czech Technical University in Prague.
Message-ID: <20200825021657.GA3801424@bogus>
References: <cover.1597518433.git.ppisa@pikron.com>
 <8d0674796f3c4ecfd6fcd66ae79bc3aeb93ace22.1597518433.git.ppisa@pikron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d0674796f3c4ecfd6fcd66ae79bc3aeb93ace22.1597518433.git.ppisa@pikron.com>
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat, 15 Aug 2020 21:43:03 +0200, Pavel Pisa wrote:
> The Czech Technical University in Prague (CTU) is one of
> the biggest and oldest (founded 1707) technical universities
> in Europe. The abbreviation in Czech language is ČVUT according
> to official name in Czech language
> 
>   České vysoké učení technické v Praze
> 
> The English translation
> 
>   The Czech Technical University in Prague
> 
> The university pages in English
> 
>   https://www.cvut.cz/en
> 
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
