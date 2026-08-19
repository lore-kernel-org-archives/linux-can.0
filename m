Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7558C3C13FE;
	Wed, 19 Aug 2026 03:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787109268; cv=none; b=u7VTc4Buc+UfM340bXeKTbOy2UsasgPQfHlTrEPH1o5JCAXzghKhT1pOweLNVt20s6Wjm68wnaMyzgkY/5rFXLLvepDQja5FsllhBLGYf4MbwfwkixrC03RdgZ/8aBDEjPVCIaBhNR9NAL5weIXYAOtIDG5D+Ll4hdNvWKvu8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787109268; c=relaxed/simple;
	bh=Ii1mnAQIk3JxKPtw1+lNgA5Zgg05+1uKMZeaIO1HU7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HZ5/z9kx4+ZupMrphUqDsWsQkULTgZBO0pms6cJWM4TvBNiGykqrZvjcDh9xYcTrosKNvrH0CSGTihxPr27CQU2u1wNzsmn+fK5tiU04xrvcxmFu+S1OQUOB326E/XSBJceyTYROkKmIP3Cy9uyR4ELKrBHhNvBQ9LUYSyHukfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BnEUPud8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BnEUPud8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787109266; x=1818645266;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ii1mnAQIk3JxKPtw1+lNgA5Zgg05+1uKMZeaIO1HU7o=;
  b=BnEUPud80n1F2dPN1NLQ070xyUUTak4Tm3SLMXRI+g1q7X17MnSj4jtq
   rVtG+Fjt3X2GNrVVMydgg7UY2bP3tl3c9fDCdBN7xZBp44KicJk1NlXp4
   LU4LnzsjE1mPvw3TVtuIbEEAArywR3mGzj6NNfh8NUlwWkVU6rCRnouUo
   0ieusWcGM/kv+wKkpwf74qIwxGbhTWOe7s0dPYmfGPFBY6J25wC8DpaIv
   6uumRqwTEUN2L8I7nLN9+n3F/7UId525RyPnLKWZDropnLMzbz4x8K2GW
   4lHud9vA4ha7iwEnAmMPW9F3Veg9H9dYw5Ial/fG/zUBHn24VnMQsrNrq
   Q==;
X-CSE-ConnectionGUID: J864rs4URjeHfXVvhbskAA==
X-CSE-MsgGUID: IZR9RznkR1GhxX1awoXUaA==
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="72077587"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 20:14:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Tue, 18 Aug 2026 20:14:19 -0700
Received: from [10.40.24.197] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 18 Aug 2026 20:14:11 -0700
Message-ID: <93f0727f-0b25-4374-9a6c-ad3799006440@microchip.com>
Date: Wed, 19 Aug 2026 08:44:10 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/4] arm64: dts: freescale: Add chargebyte Charge
 Control Y
To: Stefan Wahren <wahrenst@gmx.net>, Selvamani Rajagopal
	<Selvamani.Rajagopal@onsemi.com>, Ciprian Regus <ciprian.regus@analog.com>
CC: <imx@lists.linux.dev>, Oliver Hartkopp <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, <vkoul@kernel.org>, <olteanv@gmail.com>,
	<devicetree@vger.kernel.org>, <conor+dt@kernel.org>, <Frank.Li@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>, <linux-can@vger.kernel.org>,
	<neil.armstrong@linaro.org>, Vincent Mailhol <mailhol@kernel.org>,
	<robh@kernel.org>, <linux-phy@lists.infradead.org>,
	<sashiko-reviews@lists.linux.dev>, David Tumma - M78440
	<David.Tumma@microchip.com>, Roland Trissl - M21193
	<Roland.Trissl@microchip.com>
References: <20260818091701.6441-1-wahrenst@gmx.net>
 <20260818091701.6441-5-wahrenst@gmx.net>
 <20260818093147.E556C1F000E9@smtp.kernel.org>
 <89573332-94a0-4fc9-b4b4-be100a97de6e@gmx.net>
Content-Language: en-US
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
In-Reply-To: <89573332-94a0-4fc9-b4b4-be100a97de6e@gmx.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Stefan,

On 18/08/26 7:10 pm, Stefan Wahren wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
> the content is safe
> 
> Hi Parthiban,
> hi Selvamani,
> hi Ciprian,
> 
> Am 18.08.26 um 11:31 schrieb sashiko-bot@kernel.org:
>> Thank you for your contribution! Sashiko AI review found 4 potential 
>> issue(s) to consider:
>> - [Medium] The LAN8651 ethernet device is missing its hardware reset 
>> configuration, leaving the `X_nRST_LAN` pin unmanaged.
>> - [Medium] The SD card slot power/reset pin (`SD2_nRESET`) is named in 
>> `gpio-line-names` but is not associated with any regulator or reset 
>> control.
>> - [Low] The GPIO label `X_LAN_nCS` is incorrectly placed at index 0 of 
>> `&gpio2`'s `gpio-line-names` array, but the `lan8651` chip select is 
>> actually wired to index 8.
>> - [Low] The `ti,leds-polarity` property used in both Ethernet PHY 
>> nodes is undocumented, invalid, and will cause `dtbs_check` validation 
>> errors.
>> -- 
>>
>> --- Patch [4]: [PATCH RFC 4/4] arm64: dts: freescale: Add chargebyte 
>> Charge Control Y ---
>> commit a177a5e0acba62156876ea6dc84457789786bfb8
>> Author: Stefan Wahren <wahrenst@gmx.net>
> ...
>> +/* MCS Ethernet SPI */
>> +&lpspi3 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_lpspi3>;
>> +     num-cs = <1>;
>> +     cs-gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
>> +     status = "okay";
>> +
>> +     lan8651: ethernet@0 {
>> +             compatible = "microchip,lan8651", "microchip,lan8650";
>> +             reg = <0>;
>> +             interrupt-parent = <&gpio2>;
>> +             interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
>> +             spi-max-frequency = <25000000>;
>> +
>> +             nvmem-cells = <&eth2_mac_address 0>;
>> +             nvmem-cell-names = "mac-address";
>> +     };
>> +};
>> [Severity: Medium]
>> The pin X_nRST_LAN is labeled in the gpio1 node, but this ethernet node
>> doesn't seem to configure a reset mechanism. Does the LAN8651 need a 
>> reset
>> control or gpio-hog to ensure the pin is driven and not left floating?
> according to the current DT binding of LAN8651 there is no reset
> control, but the chip has a reset line and its wired on our board.
> 
> Are there any plans to implement reset control for OA TC6 or LAN8651?
Yes, we have recently completed the implementation for handling reset 
GPIO, as well as recoverable and non-recoverable error handling. We are 
currently preparing for the internal review process, which is expected 
to begin shortly.

At this point, I’m unable to commit to an exact timeline for the 
completion of the internal review and when the changes will be merged 
into the mainline. However, we are making every effort to complete the 
process as quickly as possible.

In the meantime, if you are interested, I would recommend using our 
early version, which already includes support for these features and is 
available to customers. Please reach out to Roland Trissl 
(Roland.Trissl@microchip.com), our Technical/Application Support 
Engineer, and we will be happy to assist you further.

Best regards,
Parthiban V>
> Best regards

