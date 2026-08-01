Received: from mx-8.mail.web4u.cz (smtp7.web4u.cz [81.91.87.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D810D3E3DBC;
	Sat,  1 Aug 2026 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.91.87.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582148; cv=none; b=KcDOsmLx0JiIQkGYRWkMk11RR3MW7R7CRoxCxH6e+BKPi1jYUoTR7krY1RUDg08JoWZFSgqBpVv9EBNjekSta2JwKz/R/xzF7vdiLaoeC1QX4ZO2dDX2F3Xas2lfbauevzYJztCXKo73FHcp6/cwFCP1QJ1Y7eQzyX8xU4ocQoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582148; c=relaxed/simple;
	bh=diTGh9pGYI+gWDvk3pLllvaE0gYZHY05lhYAOIA8QlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+TAdtXBZoV+C/L4iue4U3v5Bf/I18/BsKESo6ue6768WScIh4lswBmk7iIRxvL1dRsUXjphmFEG0BMPob/aXv9Lmn/olDF1Ks2rldMslM6gUpMXHng/2U1uo9+v8IsA7UXKNtx5to3gsYnk/xHDkDERaOeyhl721UitdjVgByo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pikron.com; spf=pass smtp.mailfrom=pikron.com; dkim=pass (2048-bit key) header.d=pikron.com header.i=@pikron.com header.b=yK085N9C; arc=none smtp.client-ip=81.91.87.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pikron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pikron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pikron.com header.i=@pikron.com header.b="yK085N9C"
Received: from mx-8.mail.web4u.cz (localhost [127.0.0.1])
	by mx-8.mail.web4u.cz (Postfix) with ESMTP id BC2C92024E8;
	Sat,  1 Aug 2026 12:56:34 +0200 (CEST)
Received: from baree.pikron.com (unknown [84.242.78.234])
	(Authenticated sender: ppisa@pikron.com)
	by mx-8.mail.web4u.cz (Postfix) with ESMTPA id 65FD820247E;
	Sat,  1 Aug 2026 12:56:34 +0200 (CEST)
From: Pavel Pisa <ppisa@pikron.com>
To: linux-can@vger.kernel.org,
	Linux Documentation <linux-doc@vger.kernel.org>,
	"Marc Kleine-Budde" <mkl@pengutronix.de>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Ondrej Ille <ondrej.ille@gmail.com>,
	Jiri Novak <jnovak@fel.cvut.cz>,
	Pavel Pisa <ppisa@pikron.com>
Subject: [PATCH 1/1] docs: ctucanfd: fix swapped colors in legend for TX buffer FSM of CTU CAN FD
Date: Sat,  1 Aug 2026 12:55:52 +0200
Message-ID: <d775feefa1c16d7ea7f42482483c81491f75ce6c.1785574572.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1785574572.git.pisa@cmp.felk.cvut.cz>
References: <cover.1785574572.git.pisa@cmp.felk.cvut.cz>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Pylter4U-dkim-type: user
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pikron.com;
	i=@pikron.com; q=dns/txt; s=w4u; t=1785581794; h=from : date : to :
	subject; bh=diTGh9pGYI+gWDvk3pLllvaE0gYZHY05lhYAOIA8QlU=;
	b=yK085N9Cu469XSjKLvEXIf6vHyvL+UDvrhiJ3sgiuzrFLwEmmdUL+cgLwsAMRdmVGccrF
	K3BAq3+g5HMN9cku4WKFE5pyFQ/piHu/r01J3EgC6bAbb6ABx202aXuSwR2eomHwK9mtMaf
	Io33/d1ghl71oufrbSvibs5CLAeNSOCMJOfQiLlFRoFBW7vw0JpY2Y4XbzfeXZCQ53jFvKN
	F+aBbPg31XJ3mX6d0h4ny9iBiSBQbIPXb2cesUVj8dQqdDG5tbvCFrZ0OuBhq2KTFCtcxqM
	kjcrFTpcNVvgUerOKLZcG6i5KYd9NqLfZfvMKU8QqAoxGmZv6Ng2LPOdCxjA==
X-W4U-Auth: 5acbfc1bafd0ba02eddfa61b9e33c05656a20c63

The Inaccessible and Accessible legend colors has been swapped
for many years. As I have helped to clean the CTU CAN FD section
of official documentation for mass produced silicon (multiple
models of microcontrollers) with the company representatives,
I have found the problem and propagate correction bask to
the primary CTU CAN FD sources.

Signed-off-by: Pavel Pisa <ppisa@pikron.com>
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
2.47.3

