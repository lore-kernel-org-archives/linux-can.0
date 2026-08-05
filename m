Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A226382F28;
	Wed,  5 Aug 2026 06:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910316; cv=pass; b=hC3Ed+1IJ7GL3NljF0+Y257QEsr5edIX5A0pfPgaxaYijkYJ10KtX94MkzSmRX9hYv3CqGqjvJO5Ld5MYiXCP/ImJzhm6SOb+yfraohsUxwgJ1j+oV2MPwwQ5bT7boDDDup80dgNI7AQuqkFZckjbYSjZhIWP8y4KTwJVI316Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910316; c=relaxed/simple;
	bh=DHYK86d9xVLALzQNwJkcrgXIW2xJnPmrDziLV3JA77k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STwiI1XO8za6GUwuPT92BFTp8mVwYX09mZeeaB7YIvfMV195HVfZ4pbPjLzo3k7eaqLrWwu4Gzgp2JRM+5hdjClecqKq2uiqvTxUAKH0Ge3MmIPcroToZRWbxTDgs96wy31tgZS8yVOhjWJms/VZSYxl8H4wQOINh3DEPIYd2e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=l1MRMbzD; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=z7fxIoev; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="l1MRMbzD";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="z7fxIoev"
ARC-Seal: i=1; a=rsa-sha256; t=1785910121; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Y5llUBe6z/yBsY6/Pa0/d7gTugfwmt3ScjXf78YvZi9cBY3KGTSyx9q9Ad70NnQBOa
    iWUryYql36/7OkFn9n9RN0iSeBjLAICNGymu4aozlwbs7dLBLsyAnOLiKh68sSZeidAV
    iTuHbpYSiAJblNgLVzPD8fHrUSSCLxAT7B1/dC+3vqZt/9CwEvip4xXCULkKNUlXAYRC
    vnoJHh3vgjJcWMbyRYEP0uyRkhTCIQI9TNhvfPRM/Nlxi5+BNHEwkPfXWBfQKaYZm8mn
    ByKbMB/S602pQKCsfeIYm+TKMhbLAzWfuySmQP/xN8rIaEGmezXFcwYlRQAJo+4H6ODW
    Kjtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785910121;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=NSZiC6gBMOtaquQo/odME5gnA/westwXWvyZQuCotG4=;
    b=lvhAmiwYbpw6eHvLZhTdMsKykaLRxipHzSwse4HftRucyhdzD02ICBrgo57FS3PZsZ
    /TBU+cymSi8NNMm3MGE9vCXdtjcmqV89ZrpUpYqHXexn2TYztoxge7vtjGznt/aLoxrA
    d5f68enB+4+xy4xTw096dyCoIWP6yP34pOOJM5msZbzBUX8frtkqXxaTRjDal1NrP6Ht
    QZu65HI5b+ED3L83j39vwNA/ykQVjGhyg+/8UcGrRnOkt1KHkKeV/5SGwmBVPcQ3Ci7C
    mgmrX9gjkKOaiUg6oS21ZfVRZCKD/I4LYw45OsjAbmnmseYqe2BQLVEVUOJxAfIfvM4J
    GZcw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785910121;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=NSZiC6gBMOtaquQo/odME5gnA/westwXWvyZQuCotG4=;
    b=l1MRMbzDzyO+2g2TfLgbTPmb2b4/WO+zP9K4C+Niq91yPYikZG/+/9uYtNqkXVkihn
    1L9lEeAO3S5UuJRRGtzE0y1GvQDPdVQXcubx0JQBnhRY3muf8mxKjAMAQose4qynIhu5
    5NL2K002d0gtYvcq1jQ46T5LlzM2F1T3wsQtXdNZaqHsUm+ShrFdtlzbm46RhlB1YrB1
    heRoImzvSwVUQEaBaTUOfiDe4Rb5BCIqkDbxf39CbQF/lR1KDyejdKdnSzXJw3l6bNoe
    joLtT+KcCFyyUZeWX8ii1hL/Se4UsxsQAxT4JGfEmawFXOlSjlVuISzaoQFi9oOknouZ
    zoVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785910121;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=NSZiC6gBMOtaquQo/odME5gnA/westwXWvyZQuCotG4=;
    b=z7fxIoevKgpaAjOevNRyAcDwsxeFCFTDzsmz+NeQpVnXiBvXZFBrz2Pu8u4twbLshm
    fXgdyrtxeWNdiJ9Rn1CQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id K5281927568f16F
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 5 Aug 2026 08:08:41 +0200 (CEST)
Message-ID: <b47de328-322d-46b8-88e4-af12fbdbea64@hartkopp.net>
Date: Wed, 5 Aug 2026 08:08:35 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] can: fix IFF_ECHO example in documentation
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260804-automate_iff_echo_flag-v1-0-26f06ff0f8bc@kernel.org>
 <20260804-automate_iff_echo_flag-v1-2-26f06ff0f8bc@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260804-automate_iff_echo_flag-v1-2-26f06ff0f8bc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04.08.26 21:55, Vincent Mailhol wrote:
> The documentation suggests doing:
> 
>    dev->flags = (IFF_NOARP | IFF_ECHO);
> 
> to set the IFF_ECHO flag. This is problematic because by doing so,
> other potentially enabled flags would be overwritten. Furthermore,
> none of the drivers do it like that.
> 
> Replace the example by:
> 
>    dev->flags |= IFF_ECHO;

IFF_NOARP is important for CAN interfaces and it looks like it could be 
missed now.

Please document that IFF_NOARP is already set in can_setup().
E.g. out of tree drivers might stumble into problems when they set up 
the flags differently.

> 
> which is more robust and consistent with what all the drivers are doing.
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
>   Documentation/networking/can.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
> index 536ff411da1d..fbd0d501ea4e 100644
> --- a/Documentation/networking/can.rst
> +++ b/Documentation/networking/can.rst
> @@ -1126,7 +1126,7 @@ e.g. of tty devices. In this case the driver flag IFF_ECHO has to be
>   set to prevent the PF_CAN core from locally echoing sent frames
>   (aka loopback) as fallback solution::
>   
> -    dev->flags = (IFF_NOARP | IFF_ECHO);
> +    dev->flags |= IFF_ECHO;

Here also a documentation about IFF_NOARP is needed now.

Best regards,
Oliver

