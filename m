Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56DB45518A;
	Thu, 15 Oct 2026 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096473; cv=pass; b=NdmjPrwGd0yq0fsPlCTzsAUW2DppWu8nkGYGEBkBy/sZZ8zCgbTJCTFuSyOfndhnyP50FtF+58SzfUuP5Piw4m/7wMufoxXIr4+T/yh2KXWDdUiYzSNqeKLSIotoWSZqMwWGsjmoB9OJJetm7pzKv0XzG2bO/TcgzbuKLSbbT+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096473; c=relaxed/simple;
	bh=Ki1nc1wLOd06aL6II5mTlhbWZSxBbp1wQ0ANBLHqbjU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Dr1rg6UiuW7mF6tdFwydRXlPT3ZQmIVxsByoUgLsGb6mJneOF6/4k/J++oeLPBqRrONgBeoTCPzhjx5JxmTcJEIXDw0MR0u/bu/HUsM76ToEt7iO1r6kWn8clcHkyLF+EAMsePgP/49vriy3POqoHFdXU+cAlzurSDFeTrDb8o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Lecw80N0; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Lecw80N0"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8709E2027D0;
	Thu, 15 Oct 2026 22:34:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792096462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9EfYce5pRwlUL/0AkqOCddWy2Z6YqpeOfZA2swoItlQ=;
	b=Lecw80N0w9Ti60Hl0wIgoKjEwDgjczt8QYy1YpNWDzM4Dg0pIvnAFLB4VTcE+/hMEJlGxq
	F6iYdsawwHZPB8+yYCo8BLqvg02IofixjmKVEHtdp7DivpkJFe4O3UD5v8tU1A6b+9D+78
	DmRqS8TLs5Gzy8LhNoJ7HFnf2pmdr4zwcIuELeIA6PVV9ujtd+uNtg48FRydn62k+WyT2R
	D34b5BXD9/7WoAVFhb18hgh7lCs+Pkj96rDNULX9bwsNrORuCzKFTzfDVN1Hc0DuamRE7A
	bBwGfYzpoJDNKU1UnkPVfO4+MER5V+p064Fo0G73DYbyGuhf+3744fQWUMtxAQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792096462; a=rsa-sha256;
	cv=none;
	b=arxxCosPI9J1pN+SGkuMpTek1iwLdBCMcqMtW03bhvDa9IfHxNXWRjpVqqGEDamDHrYph9
	cSZZwhX8nirCSjezLurJbns6WlQbi5mZqqYSe9HH0qqztB/Qxt5ZW94OhudWT30fflYBjQ
	krZxVJaTpWACHlFc3tqk1CHZ9ldUduKHPAOzj2KDlXSDAGvzZXPV1Kfhf/fg1/Y7lItte7
	Zzy3QTLm7bJ4GHzjREFyPZEE6ZPch+g83Yf6J9vd0aKCT/0HXQuX0cvE6K0uQoMbIPjC3q
	BReLR0EkLAjE2a9NzYbmPnSQEW2vbAchTqBQIhw4sZ+OfshWXjMHEGoSwVx6Yw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792096462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9EfYce5pRwlUL/0AkqOCddWy2Z6YqpeOfZA2swoItlQ=;
	b=AaNVNi7MpJLC4MPQ1GzL+ohh6Tc3adUR2FCx9ZY2qTVaVnZqForvNAIx1dT4YfeLSyMiTy
	HEFf9Ck6p0Spv1zhzkb5e9ei2wSpN4sOsugoKqa+1hNPvrF/+cSvTxRaoKqXzRY5U+omjy
	PUs1aIrRrL5MtLGiWwmF6V1ZCzYRJNOt5lbYeaZ5TXXuAlvws/Zvdyx5TsA8IO6P3lCCOm
	Y/4K0t19JmtXjVZKe0M7cq25p6vxvhkHTB2CMV52mnLWW5E75c2w9jkziylwToSOYUWI8g
	f4zeG/w5Vcn5I18GfBN4PRwVFW8Ymyspxs+glI7EhTSo8YKJXUi+ilZA07IIDQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHS9e-0064sz-17;
	Thu, 15 Oct 2026 22:34:22 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 180615C570F;
	Thu, 15 Oct 2026 20:34:21 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 2/3] dt-bindings: net: can: holt,hi311x: Convert to
 DT schema
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Rob Herring <robh@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20260923013812.256689-1-quchaosheng000406@163.com>
References: <179008111842.3145564.13410709686921168865.robh@kernel.org>
 <20260923013812.256689-1-quchaosheng000406@163.com>
Date: Thu, 15 Oct 2026 22:34:18 +0200
Message-Id: <179209645876.1181445.17999194781071685440.b4-reply@b4>
X-Mailer: b4 0.17-dev-6be7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=685; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Ki1nc1wLOd06aL6II5mTlhbWZSxBbp1wQ0ANBLHqbjU=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6aHHqwIUJCvJihSIrPu77s+1L/6orcnnVcsmsNVfO8
 U3JN8tJ6ShlYRDjYpAVU2RZ+uOEokCgQ2nvy4RJMHNYmUCGMHBxCsBEmqMY/sddyPuZ+v5XxAq1
 /n2H5l282WSWceneJcE10lNehR5olUphZLhXHnL299HFcy+LPXX1vq+o73FAzaRk7Y7vTRlqVRl
 MEZwA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Hello Rob,

Quchaosheng says the error that your bot finds comes from the latest
dt-schema git.

On 2026-09-23 09:38:12+08:00, Quchaosheng wrote:
> Reproduced. The errors come from a dt-schema change in git, not from the
> patch.
>
> They are all in reserved-memory and the IPs that embed it:
[...]
> That commit is not in a release yet. Confirmed on the same tree with no
> patches applied:
>
>   dt-schema 2026.6 (PyPI)  -> clean
>   dt-schema 2026.9 (tag)   -> clean
>   dt-schema git 840a01d    -> reproduces the errors above

Can you re-trigger the bot or should Quchaosheng re-spin
the series?

regards,
Marc

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
