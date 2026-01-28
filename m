Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697BE2DF138;
	Wed, 28 Jan 2026 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769618788; cv=pass; b=FuZqxqgkFQMqIri3KwMYTc3ukn6+TPkEC8A5o24zZ+B/36UH23f2ncv6PjONIicslaEzPpkM9fgZWb75oVD7Nz+LUzh5HQJE/45HWpV8r1ys9oy1ciqUEes9CDAkZ+ku/YGconiLFY6nOvSx4dOR4bQFMlF/4tjPSaJXgBRuuf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769618788; c=relaxed/simple;
	bh=TIMZQnaZKcAN7zxE0UIFMI3iHGOH1+6QecVYLaFUL5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Au8RbZ34tKoGOmqaQjo3Yd1TeIxoz93VJfshJlYyTVXEKNcZ+obHH06mWRE9d3yh08EXU2GLyAUYD8Qx8BnsJz1d/CdI5iPab1ydTDXSFyDOcRpGB39ZNAFLEHm9bLN03Dfaa++4zXhVw93dMSUzImv5LQhqvhX6uE4g6/nQwlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=fHKXEejq; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=r3Cb863Y; arc=pass smtp.client-ip=81.169.146.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="fHKXEejq";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="r3Cb863Y"
ARC-Seal: i=1; a=rsa-sha256; t=1769618062; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NGuv4URsYM0msn3DbMRfs3RiZo4uYYyRvxEZFZgTiA0AKyPUXXoX0Ux9Y/Uw0p/peE
    Is5j7TTtH/AR3b/QQXokNDlcCwFhyPutH0XzALneTlybyLyT5i0U0jIgPENHuWUcllgb
    2pUP+8dQA4CJfcx6ZvfcdFYPVBdwWWm/rROmrVve77WGOehvkjo9bNfN7ilyz+qubm+5
    X4/+Y2mg7e7W+3lQCGp7C3jqV1qXajbpy9uvQY9AkyfjAviBNk/i01fZB3iaTq3ZqORh
    OI1irMFIXaQ6YOc/hcWtCQSPF2sb5qdtLjeJTzPt+0QT8HamzLz8R6NDofwdKJ5n9v37
    64iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769618062;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=G9qVzDCPbKtH6SGk3tuleV58irPrH2dcAcJSD91WEXk=;
    b=G/Fjf6W8T68zevbHn5E40RroP10ek17hQmNmNywR+TqxINF5XfLzHpfaaoSREHC8B0
    EH6gQwKRWlIZOWM5RBa/FOEpE1ZQQQz/8m5zdNGBNBY+DPMQEjTM3KctniaGWKjh9tXc
    aktE7hjLbFYImANXkX3yfkJOZGnqzyDUrD085kRg98TlkyPULBHALY+7z8rpULyuMRh4
    mm5t5F+APaRpuw0HCVpI5OAQLadP30+oZ5WGcPobprDvLysVT0ABDxfCDLHXyGOVFT7X
    Z2oN5DTZ9vn9zzVR2c7kAOwQzbGO5BhOSh8Ak8F3Pdm3hfrH5kY2/CeCwMSOaXLdmgEJ
    utxA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769618062;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=G9qVzDCPbKtH6SGk3tuleV58irPrH2dcAcJSD91WEXk=;
    b=fHKXEejqTg+jvo1vXO2asx4cetRT1nboknSJZr/fIZjOJI/HwWzjtlEGup0GA2FkgM
    uaf0USFrgwnvXrEGjbI3lAmIQwy4Q6kZmp+7PpD2c0bAUbzHVTutK0Qtav+oz0vIhIUf
    cmDKv/4wqItAznb+elWqVldG8y8fw1I/32idwL3rwttCV9hpSmdq0OfQy2mUFlaYAZ6l
    LQi8ja7muF7D+vrEecGn+xuPYbhfPE/mkxC2zUHLX74ugt8Af7I47XgsoDg9XLydOBoI
    ftVp6b3+PBCGlNjzuDRcd3mGL/w1COmgZUrkfLX/jJb3teTZUt+dky091QF/d6oZFasT
    IG1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769618062;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=G9qVzDCPbKtH6SGk3tuleV58irPrH2dcAcJSD91WEXk=;
    b=r3Cb863Yy907u+Ov1z3i/PGd4wH64dnvNaN4jTWIIMTboNA3/znjMyYTcF12NeXqqo
    YqznsF6ZsNIEcZmaZxBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8YjX10Q=="
Received: from [IPV6:2a00:6020:4a38:6810::76e]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20SGYMoAB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 28 Jan 2026 17:34:22 +0100 (CET)
Message-ID: <f131acda-1a26-4f88-96ef-88a419e1170a@hartkopp.net>
Date: Wed, 28 Jan 2026 17:34:21 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
To: Florian Westphal <fw@strlen.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-can@vger.kernel.org
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org> <aXn0iLuRqdOdcIBN@strlen.de>
 <4909066f-cf9c-49ac-b02f-d2e16908bbd9@hartkopp.net>
 <aXoMqaA7b2CqJZNA@strlen.de>
 <e2033d96-e900-4013-a18a-c2e0ffa269d3@hartkopp.net>
 <aXo4jP9M0EQPOaeI@strlen.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <aXo4jP9M0EQPOaeI@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28.01.26 17:25, Florian Westphal wrote:
> Oliver Hartkopp <socketcan@hartkopp.net> wrote:

>> But thinking about BUILD_BUG_ON(skb_ext_total_length() > 255):
>>
>> Shouldn't this be SKB_EXT_CHUNKSIZEOF(struct skb_ext) + sum of the skb
>> ext user data which can be up to 255 *  SKB_EXT_ALIGN_VALUE (= 2040) ???
> 
> Why?  Its not about the size in bytes, its there to make sure
> ext->offset[] (u8) won't overflow for any of the extensions.
> 
> Maybe a comment would help.

Oh I misread SKB_EXT_CHUNKSIZEOF m(

My bad. Sorry for the noise.

Best regards,
Oliver

