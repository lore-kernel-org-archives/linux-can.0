Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DD33A875E;
	Thu, 17 Sep 2026 03:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617406; cv=none; b=P9Y01O+nTnUUjpwAqfFL21NQplxU58QhqIG2aOCvZV/DDiwy5aDEsFVdSYfWjN4mjtt6LRDpUDsEsCW9Hqokrs9ezLo0kG8wqkp/WUeAL7dQwoH2sdQNZA90Q4WatgLafpmLu1ILs5q/fG91P6QkvhAqOwxr0UvF1szZEbZgw6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617406; c=relaxed/simple;
	bh=V9apvguckonBUFoZkOgRC8OEVq+mcYokc6e8jZMQp4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LH74Dpuh57j8yT8AT0c2EsbgCf4pAU0+AxDMUGfVQU5zFWBDu6vrcMhh6M/mP7kq16GWJPYaaV/gxj/hR/0y6MM73tFv1IB5Tq5IZeFC+mGtuX+wkkQG4NH8rM3e7y37u+zAPr8+RPOhMavaRolmORk9ytVgDU6Pdu+5+Jzu42g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=fTYCLd/b; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="fTYCLd/b"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 10FDA1001F5;
	Thu, 17 Sep 2026 05:56:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789617400;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=aulBUN1tA6kZl7+XoEHv5GG7KpCshb3srvdgPwEckPM=;
	b=fTYCLd/b8tZaj1yEk4+fsOJXwg9sE1xiH+ukXXaNflaaPVgY5VDF0EelJK2TUmgIEEe48x
	S4TPBF1LiO+6E/iIq8AI8Y7cICuem9O4Kc4ln0s8kBwprNKMZB7SXMiGPSZ2mkIEXm8PAh
	QtyfPHHn0BItAZpJ6gTN/3CfluNSlZj6W+Tih3wueUBtcqCoJH7JVvBpv/2ed+NiiGVMy3
	R8Cyci3GmmhYmvD/WHnBxykEQiOzY10AXAQc3rIZX6/I6z3HAn6Yxp/okG7HHZs8QGouqa
	iPDC3VpZtvg2yQwoNoxs2tcqFDZT1EoPxyTmKo/Tr8pZqI5wT+E4tjwX3HkOow==
Message-ID: <f4dbeaac-ab10-4980-9fc5-533907be223c@nabladev.com>
Date: Thu, 17 Sep 2026 05:56:35 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
To: Frank Li <Frank.li@oss.nxp.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Aswath Govindraju <a-govindraju@ti.com>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, imx@lists.linux.dev, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260917024805.517030-1-marex@nabladev.com>
 <20260917024805.517030-3-marex@nabladev.com> <aqtfcREBJLMzS0gn@SMW015318>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <aqtfcREBJLMzS0gn@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/17/26 5:33 AM, Frank Li wrote:

Hello Frank,

>> +	reg_panel_vcc: regulator-panel-vcc {
>> +		compatible = "regulator-fixed";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-name = "PANEL_VCC";
>> +		gpio = <&i2c2_gpio_expander_20 17 0>;
> 
> 						  ^^^ use predefined macro
> 
> use gpios = <...>
Is this all, or shall I fix something else before I do V4 ? I feel like 
I am already flooding the list too much.
