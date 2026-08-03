Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D541CB20;
	Mon,  3 Aug 2026 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773501; cv=pass; b=ZqfWPJq4/m836nbL/fnSyZPjfYmajlednwlR6buIQ7CFVm8oQrTof6Ztqn8s02fbAk+prB5pRFfqPFTDFH1EATbO6s339j0y0n9KdD2AkTY/jq4xrls/L36x11KxpK+sH7x1e/ZWgXF1iDlTjVldWt4e+UKMyIF/VRcQM5VbxdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773501; c=relaxed/simple;
	bh=jotNqgCztkp3Xeor14/oCMOxmbbq70siUCKsp4sE8ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YH+T+CBD9xuWeU82HJPZ/KvJZEHS2Fe84h75QenIaEfdbYMXy7TtVwJBy32/vswS1yo1Xy+UkehEWOt3hpZ4Lq3spI8e32cvABLIjaTbxTyjwU2UWvd/TjKn9FT8I0bHQoenZITdK9LgyglwtVhyCFnYRRU5toR3Nhbao7/SDeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hFQbDHJo; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=aIy8soE4; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hFQbDHJo";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="aIy8soE4"
ARC-Seal: i=1; a=rsa-sha256; t=1785773130; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=odhMUvWprXX5AQG5EfHg9t08CS1eyZGM6QMil/FqzzU9zD6CJ/MSsLe+/c0PJSTcrI
    S7zuV7UpLmoxkibaxWUPl4Q17UrgG84Zb8K40trKLNn4MtoGLCxGT8NugcjbHlthB9Ra
    iJEK9mDD7l7LyIa9bTzFiJiV4GRf5Y4THGh0vx4u2phdIOQZtaEC9A4eJWZOa1jwEBRi
    ih68cqvIglklr9lX/i1SIQEEG8yw/BP2GcnBBtxgr2WfV8QQOIJogRc7e7GTdHomQf9H
    kWf2cEouQ4kHBQQpD6/nu34TzJcJuQVS8qWIVNn5NM/9Adl93VHlsAwHTrzNJ/vvqUNO
    6ukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785773130;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BSb3GcMKg+gyzYLX8t+TY5utwwyEasIW2FI0UXjAEOE=;
    b=GCayWMoVoo2wah0cjDq4CT/7zA/vKCS/JBSJNjnn2Tr2unAJkG3RvbLtthPXhcFlIq
    JYrC0836ZGwiGxJJ5SDyBkaQDVULOOSfP3zoHishFu9mB94uuWO5BQV458pDSzJjblf0
    6axchh/Gk/QwuxhhPK478tjkpnpN3UT22yH26GaFTSRVkdCcwKONMgEtigAmys9pW1AL
    s9gMIhAJAwtBGVpMZylIUBpX6oTE8xhJ7R31A3znZupXG47YnGs/yIw/4Rc7hTXD5EUp
    3NyrFkS+Hajy5mGmkhFV40aFK64UYL+qniYH8nrrIrPhTQ9nJggvGdRnGcoskbz/Al0z
    INlA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785773130;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BSb3GcMKg+gyzYLX8t+TY5utwwyEasIW2FI0UXjAEOE=;
    b=hFQbDHJof3NxIHeuJfSDM/BIElQlV3Jx0m32626Db5ZwzxUruuVvwe6CMs1RmcpheM
    Kxec8shEtxJzTuGG1AggNAmfIjkpKqAvTtFknb42haDCfq+AFU6QAjOmNjdFublWSgjd
    H/mEVOUaYQOZ946/G3bS2M6YM/PEz+TR+OpXGHl4hjcSlpZp00fD+HTlokESy9KPEJxQ
    UslBJVo/zIiDf17E4U31rHdaq548pNF3U46XLXP/pPoQobw5eo8pVJt0QPub01VUPJ8D
    xmgwGAh7XC2Lske4mNNIhWbCQNlmjlcWBg52+dlNth3URuc8nWTYq0iw/MmxnIDkJgR+
    kjeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785773130;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BSb3GcMKg+gyzYLX8t+TY5utwwyEasIW2FI0UXjAEOE=;
    b=aIy8soE4u3PWlBnK4JAWTflUE+DiGQmlefUmzXFWZqAT6cECpYPeCX4r6aB3gJlOAD
    0f0yZozsJzDixm/gdqCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id K52819273G5Tupe
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 3 Aug 2026 18:05:29 +0200 (CEST)
Message-ID: <5eb9a4e8-383f-42bc-bf4a-4ce626916828@hartkopp.net>
Date: Mon, 3 Aug 2026 18:05:24 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] can: arasan-canfd: add driver for arasan CAN-FD
 controller
To: Jisheng Zhang <jszhang@kernel.org>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260803140531.12692-1-jszhang@kernel.org>
 <20260803140531.12692-3-jszhang@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260803140531.12692-3-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03.08.26 16:05, Jisheng Zhang wrote:
> Add driver for the arasan CAN-FD controller.
> 

> +
> +static const u32 ecc_syndrom[7] = {
> +	0xC14840FF,
> +	0x2124FF90,
> +	0x6CFF0808,
> +	0xFF01A444,
> +	0x16F092A6,
> +	0x101F7161,
> +	0x8A820F1B,
> +};
> +
> +static inline int parity(unsigned int x)

int / unsigned int ?

u32 might have been better.

> +{
> +	/*
> +	 * public domain code snippet, lifted from
> +	 * http://www-graphics.stanford.edu/~seander/bithacks.html
> +	 */
> +	x ^= x >> 1;
> +	x ^= x >> 2;
> +	x = (x & 0x11111111U) * 0x11111111U;
> +	return (x >> 28) & 1;
> +}
> +
> +static u8 ecc_calc(u32 data)
> +{
> +	int i;
> +	u8 result = 0;
> +
> +	for (i = 0; i < 7; i++) {
> +		if (parity(data & ecc_syndrom[i]))
> +			result |= BIT(i);
> +	}
> +
> +	return result;
> +}
> +

IIRC there's a even better solution with already existing kernel 
functions (e.g. hweight32()) which can use optimized CPU operations e.g. 
to count bits in a value than open coding the parity function.

#include <linux/bitops.h>
#include <linux/types.h>

static const u32 ecc_syndrom[7] = {
	0xC14840FF,
	0x2124FF90,
	0x6CFF0808,
	0xFF01A444,
	0x16F092A6,
	0x101F7161,
	0x8A820F1B,
};

static u8 ecc_calc(u32 data)
{
	int i;
	u8 result = 0;

	for (i = 0; i < 7; i++) {
		if (hweight32(data & ecc_syndrom[i]) & 1)
			result |= BIT(i);
	}

	return result;
}

Please re-check if you can use existing kernel code here.

Best regards,
Oliver

