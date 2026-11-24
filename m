Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510457;
	b=wyFMH0wlJ/tAZW++tPqaiTJXcmZOoH7DdvsZkzXPPSc6WPEuN8vifDdx5B2K3xcnXmqz
	 km46LTl3V1MPgUyLYLuS2dRDIEDkCjHO3aiIxtKbd7ACmyr9HJ/1SQL4dJ0jopOeybHEa
	 gJKgPyYlo1jRtbLp4icEwiMecx/ThMlnWXYF07xDGdqEZskjQa6fIJQwhuvP/zUIhxOOS
	 ExJmLyu1jb1U4dx8vK3Xrp+07fKFQ5I/VPs7bN14dzaiEToWAxIM6r2Ttngf0fe5kBt+0
	 sRK2U04q21LIYp5uZCgla18y/UNoZJOVrY0OiJud4IoisGbc2eF+PuV4pka/C4as0cA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510457;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=BkiqNFJ1f4nMWpGXOtHzVrT03iXQGGM9m4D4fspgoGM=;
	b=OEPDaqkr/l5ZaCT/SNk2Xtlt9VsAaX+sHRGqUS/qAsc+s+iJX3T1+iN5OuErYr3uUQEO
	 txlP04/4gcR7I4TyNeya89qx4AN97pcLb/vELqn1vkkbEMupP7y+ttJN4QGv/8mARou4P
	 Gws2s/Tm4RFTdPuIFmsa7buoPezNZarMWzX7NipJ2JP4HXCNZesm5nKd/2M0eu/c4CvSr
	 t0WboMPNDmGyocBcdxR1sw5CleLqSSb+9Ut1x52bjmQgclUqkT7FEzRDJtOyWOP2YSk3b
	 K/4BTPuzSKM5DgFEFV8u/VaVJgs5lXOCC09vCsnDx/lb2cFmkI06Oo8F7dt0g+iqzFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=HLbucOis;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=+VxbI9WM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.25
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB666606A321
	for <linux-can@vger.kernel.org>; Tue, 24 Nov 2026 08:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB666606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=HLbucOis;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=+VxbI9WM
ARC-Seal: i=1; a=rsa-sha256; t=1795510448; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JyLXk7ewwNfeTSPIRFks2R/donXw3uWpnDraflQQYMa7yFPDKDNNNLg8OPW2Me1Oyq
    Ajt0aAaQaafKMwZqE9Amn+5BsV4cJPvTBhg1pmhij3sQkJECSq0+ZOsYsCZMPzPBt9QA
    uOIByQ5LDDOR8eieVqVfuQC7MzDWUDQhuITp42mF+vwNSGAVUH4pNohUdtaxHIfKSUFu
    /w1IIKZy6jPs4MX987bpkU12XlIuLRYqb4ZU/4Y5NSnp2Cc7ji5tyY7dgNlJhpSbfUsq
    k7ebbIAKJsbgfSvxRBq4mUJcjANCeXOFb+oyPWvAsiJKpGs/HblXTFGr4i8ChOqXDW6J
    ikxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795510448;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BkiqNFJ1f4nMWpGXOtHzVrT03iXQGGM9m4D4fspgoGM=;
    b=UfmwOkVWCMpugdz+4/WeQ8+p+Tl8cRBF8Z53P0jh7KA9Etps32IOQx7cT5exNZxwo7
    d7Qms3qGs8C+vp/3Hiv1YxKOdahabt+axwdM43zGLL9/fdkSBc2ppxeTtVpEjI10tDDh
    H5/VnsZXrFoay80XLNPp7KX0u+bj7IEVeMREIBzOYswVGAcWhzmmdIXP2oI/vt1AA+bh
    v7dMlljRB8DptH1Bmp9aChdK8mEP4OsndG5r0Y/vaceLBsUziYQmCbWfEyUjMfORgUcQ
    tKnvcll5IeLXrjI9bfbRlmIB7Z844QYzVKLDTzCI+SFMmREzBvT8QUXE4D4LOJSo8W/n
    381w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795510448;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BkiqNFJ1f4nMWpGXOtHzVrT03iXQGGM9m4D4fspgoGM=;
    b=HLbucOisrvFcpXJR9QepNOn0sdBFeiemsXn0BEHp2YjA2DN6e1pJdjrMenfxNk97Ix
    6m+XLFV8FuvlEGFt5tFFGMuweIdlqsrcIv62SACKCZOVzOi1Jgsm1PZHp7ZN/IZWi2HZ
    HxxYPrdvK0+YJrvSL2Umr5IC2FFxWKK0GEUz1OIM2326QuDVEAROt6sAMDLpVTE7G6FW
    XDepVut+U4hKmrwHPZzGxMuya/Dr9ZsVwpAXoNTB/PoCtuB1Z3Wh53Z+3J/fjgGDM+PE
    0uMP6hptEIaGHaAIY3vud5B2Pjz4AQSTDoN63qjVgauTmaHJfO+hkj/Idk6SU9bc5uor
    T5pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795510448;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BkiqNFJ1f4nMWpGXOtHzVrT03iXQGGM9m4D4fspgoGM=;
    b=+VxbI9WM8bCUwC4rb/uV43r+IxZG4S/3McJ/3kDWuWa5FZR5ZsPZjibD7H4JtQkttB
    jHJblAKirT14cLTAxMAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AO8s8gS1
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 09:54:08 +0100 (CET)
Message-ID: <f0270895-8e97-4d6a-b5cb-6da6ab5c1ac5@hartkopp.net>
Date: Tue, 24 Nov 2026 09:54:08 +0100
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/11] pull-request: can 2026-11-17
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de
References: <20261117220818.1142581-1-mkl@pengutronix.de>
 <f29308ea-4493-4146-bb28-506522040ce8@hartkopp.net>
 <20261119-gifted-tapir-of-courtesy-408880-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261119-gifted-tapir-of-courtesy-408880-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

On 19.11.26 18:32, Marc Kleine-Budde wrote:
> On 19.11.2026 17:53:14, Oliver Hartkopp wrote:
>> unfortunately we did not make it into the net-PR for -rc4.
>>
>> Do you want me to re-spin my series to address the Sashiko remarks and
>> commit rewordings for this PR?
>>
>> If so I would answer one of the reviews with a pw bot cr tag.
> 
> make it so
> 
If it works for you, I would appreciate it if you could send the updated 
pull request today, so that I can address the feedback expected from the 
sashiko-bot.

My updated patches have been already reviewed and answered here:

https://lore.kernel.org/linux-can/20261120-can-bcmlock-memcg-v7-0-f6b84f5257b1@hartkopp.net/

Best regards,
Oliver
