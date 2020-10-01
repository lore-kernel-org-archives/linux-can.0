Return-Path: <SRS0=V1x3=DI=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB9DC4727F
	for <linux-can@archiver.kernel.org>; Thu,  1 Oct 2020 09:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C30E206DC
	for <linux-can@archiver.kernel.org>; Thu,  1 Oct 2020 09:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="kyBJs4bL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbgJAJLi (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 1 Oct 2020 05:11:38 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:33181 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731649AbgJAJLi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Oct 2020 05:11:38 -0400
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4DA2F23E3E;
        Thu,  1 Oct 2020 11:11:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1601543496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HYNUMKou5WWhr98f/kjVF7WhDsYtgmKT+FApZj0wc74=;
        b=kyBJs4bLq4JQ69a6A0C+z7KD91q0Ol/WMIFZXmWSmFGPBYN+NTLNIHQDw17rh+oVR6A3/T
        OLFZvYgW+MVag+D2X2aAG1bHPwgXLPuCt3ceVmdRQttmKvxrpWOZ10+PWtRgWuKtxIcjj5
        J087Vhe2oxCeyrVBM0N7vlIn6HFkLfw=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 1/3] dt-bindings: can: flexcan: list supported processors
Date:   Thu,  1 Oct 2020 11:11:29 +0200
Message-Id: <20201001091131.30514-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201001091131.30514-1-michael@walle.cc>
References: <20201001091131.30514-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The compatible is a pattern match. Explicitly list all possible values.
Also mention that the ls1028ar1 must be followed by lx2160ar1.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
index 94c0f8bf4deb..c6152dc2d2d0 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -4,6 +4,12 @@ Required properties:
 
 - compatible : Should be "fsl,<processor>-flexcan"
 
+  where <processor> is imx8qm, imx6q, imx28, imx53, imx35, imx25, p1010,
+  vf610, ls1021ar2, lx2160ar1, ls1028ar1.
+
+  The ls1028ar1 must be followed by lx2160ar1, e.g.
+   - "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-flexcan"
+
   An implementation should also claim any of the following compatibles
   that it is fully backwards compatible with:
 
-- 
2.20.1

