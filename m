Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FB31448E0;
	Thu, 17 Sep 2026 01:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608823; cv=none; b=Ihpb1yW7S5xEVW6HCCfslzY707JKEmAX6JCC4piAdWyRTGGZHCYr7ecy9s5kmLqlICUAvMn49UdPlZRcogYEH/vuu3sZgLRoUNdH5gBCcRRAiQvrtl3pYXm/kKZ9Z0ABb3RjlscJUaIj9QRn34QL0i/vY1f/dtSo4cvdBBsWkJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608823; c=relaxed/simple;
	bh=gcr6vV++R9V3z9Z89ksXwA+Wy120Z7I0sjFQuUmErr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyMSr1FNAOvVveLKkeuQkDJNeSQH5DjRvK3W+cI361j+JrT2k+XKl5Uw+cbobbAR1oD/Bv1tigJrrJtS91tyyTb2Ida5N+DgaWjzaJZc3sJEvBcmj6sEYayFpI5MnRjjEpHbtSMgwwdDmqDVwLRrkPFoa4Vb+/KL/nNFv1CQqx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=ff5jO7lD; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="ff5jO7lD"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BFA9F1048A4;
	Thu, 17 Sep 2026 03:33:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789608819;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=gcr6vV++R9V3z9Z89ksXwA+Wy120Z7I0sjFQuUmErr8=;
	b=ff5jO7lDfNgSyyIFZ014HjYUQ3zRKemOgGAaPm2Wqbjh9t7wp76y8AP9XludetJErQxdZf
	dRIC8/0LMzsJvQ8OYYi7fJ4XGZTecuP6XJTCE9GuYFdI6FIV/eNZzadSxn69OSaSDxVA7b
	A9kMGrV3aKaH9ttnk/02w3rdLi6DrGyUr9VjjTqmZ5459wmEQJR385iw078/TSeSqxQPsR
	Aw0DcOAduWpPhabKKOgJS2a5fjR5WoxIeEWoQM2jOp16QlU0J92vB6Imrki5hkWypEwcft
	HEbgGbWyId2VCL0wbNqsBO7KbnwZol7HNWai5jh1hJ7y/J2rzs22HjiECxLwVg==
Message-ID: <d300a86a-2704-41cd-8848-6b0871037ede@nabladev.com>
Date: Thu, 17 Sep 2026 03:33:37 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: imx95: Add support for Data Modul i.MX95
 eDM SBC
To: Frank.Li@kernel.org
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Vincent Mailhol <mailhol@kernel.org>, robh@kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, imx@lists.linux.dev,
 Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
References: <20260917010906.424049-1-marex@nabladev.com>
 <20260917010906.424049-3-marex@nabladev.com>
 <20260917012032.982291F000FF@smtp.kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260917012032.982291F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/17/26 3:20 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 7 potential issue(s) to consider:
> - [High] dts: imx95: I2C expanders stuck in reset due to gpio-hog mismatch

This is valid.

> - [Medium] dts: imx95: Incorrect PCAL6524 interrupt polarity

No, Hardware has inverter.

> - [Medium] dts: imx95: Ethernet PHY reset held active due to wrong polarity

No, inverter.

> - [Medium] dts: imx95: Missing pinctrl for Ethernet PHY interrupt

No, GPIO1 pinmux is set by SM.

> - [Medium] dts: imx95: M.2 Key-E (usdhc3) slot left unpowered

No.

> - [Medium] dts: imx95: reg_panel_vcc inverted polarity missing enable-active-high

No, Controlled via DTO.

> - [Low] dts: imx95: reg_pcie1 misnamed as Key-E instead of Key-M
This is valid.
