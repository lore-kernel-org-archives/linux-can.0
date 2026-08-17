Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A133CCFD2;
	Mon, 17 Aug 2026 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009672; cv=none; b=MgEQCZC6APJ1iRR4xYYXVyAWRWdQNuMzR39XHgbpIWX3Z9wkk8FdAIqeTf4xarus9878Yhm+zrg0PQN/PlLR7I5XqWCvFJtH1ZSly7Si5emvgOEmN7cN6m0lavFLTcHA8vVfBrSfTA0eXBOp66CYB9bQMlucX0HalvQKxkj7Fe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009672; c=relaxed/simple;
	bh=/Zn9392GAwjcd9MFvLhFxrah1z6jj5+Dge4zgJCh8wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiFPqPT62oxNSBMgC8RXpzcxAFsvgVeJVM+k6PVJyQoUWLkcgBulOXzpDYD3pYMfhhPxqp0YT1DE4Y4Rb0QvEIZfeZURT3ZJgaREvYEXNKII73z5VEa0Mm3mxzjKKmYp+i31s6JdmxrmVModMH7Ayz980fEIYKuOdLh42PLXzU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AC2D8202283;
	Tue, 18 Aug 2026 01:34:22 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ww6qU-00220k-1i;
	Tue, 18 Aug 2026 01:34:22 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3B40D585157;
	Mon, 17 Aug 2026 23:34:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Pavel Pisa <ppisa@pikron.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 04/11] docs: ctucanfd: fix swapped colors in legend for TX buffer FSM of CTU CAN FD
Date: Tue, 18 Aug 2026 01:24:31 +0200
Message-ID: <20260817233420.2068204-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817233420.2068204-1-mkl@pengutronix.de>
References: <20260817233420.2068204-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Pisa <ppisa@pikron.com>

The Inaccessible and Accessible legend colors has been swapped
for many years. As I have helped to clean the CTU CAN FD section
of official documentation for mass produced silicon (multiple
models of microcontrollers) with the company representatives,
I have found the problem and propagate correction bask to
the primary CTU CAN FD sources.

Signed-off-by: Pavel Pisa <ppisa@pikron.com>
Link: https://patch.msgid.link/d775feefa1c16d7ea7f42482483c81491f75ce6c.1785574572.git.pisa@cmp.felk.cvut.cz
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../networking/device_drivers/can/ctu/fsm_txt_buffer_user.svg | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/device_drivers/can/ctu/fsm_txt_buffer_user.svg b/Documentation/networking/device_drivers/can/ctu/fsm_txt_buffer_user.svg
index 381323423b4c..c8cf0bc49b69 100644
--- a/Documentation/networking/device_drivers/can/ctu/fsm_txt_buffer_user.svg
+++ b/Documentation/networking/device_drivers/can/ctu/fsm_txt_buffer_user.svg
@@ -93,9 +93,9 @@
    <ellipse cx="144.827" cy="159.143" rx="10.8866" ry="4.39308"/>
    <ellipse cx="59.4364" cy="142.823" rx="7.36455" ry="4.39308"/>
    <ellipse cx="144.827" cy="129.196" rx="10.8866" ry="4.39308"/>
-   <ellipse cx="143.077" cy="180.53" rx="10.8866" ry="4.39308"/>
   </g>
-  <ellipse cx="110.386" cy="180.53" rx="10.8866" ry="4.39308" fill="#ffcb35" stroke="#000" stroke-linecap="square" stroke-width=".499999"/>
+  <ellipse cx="110.386" cy="180.53" rx="10.8866" ry="4.39308" fill="#28a4ff" stroke="#000" stroke-linecap="square" stroke-width=".499999"/>
+  <ellipse cx="143.077" cy="180.53" rx="10.8866" ry="4.39308" fill="#ffcb35" stroke="#000" stroke-linecap="square" stroke-width=".499999"/>
   <text x="110.90907" y="179.42688" font-size="3.175px" xml:space="preserve"><tspan x="110.90907" y="179.42688" dy="0.60000002" text-align="center" text-anchor="middle">Accessible</tspan><tspan x="110.90907" y="183.39563"><tspan font-size="3.175px" text-align="center" text-anchor="middle">for S</tspan>W</tspan></text>
   <text x="143.5869" y="179.52795" xml:space="preserve"><tspan x="143.5869" y="179.52795" dy="1 0 0 0 0 0" font-family="sans-serif" font-size="2.82222px" text-align="center" text-anchor="middle" style="font-variant-caps:normal;font-variant-east-asian:normal;font-variant-ligatures:normal;font-variant-numeric:normal">Inaccessible</tspan><tspan x="143.5869" y="183.36786" font-size="3.175px"><tspan font-size="3.175px" text-align="center" text-anchor="middle">for S</tspan>W</tspan></text>
   <g font-size="3.175px">
-- 
2.53.0

