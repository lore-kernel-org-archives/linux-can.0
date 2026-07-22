Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548611A683E;
	Wed, 22 Jul 2026 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704849; cv=pass; b=VgEs000LmdLktFJk9f1E+SW7GjeJDjcQJi0dG685ZqKhNa6gfhxB6dVnS4sIETi+3JyIX5CPT2OH3db0jIEUTzizAWptal8Kcj+pzQ9K7Y9hJTN8dBtjD3Uvu6efvKliQsppzHoE2SeHuBdXCDvldjKexcGxYTPpyexl9n3hNEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704849; c=relaxed/simple;
	bh=jHJC2iUKE5miCST+s9TqSY6jOZ0S7dgRu0rvHGkhrpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwFK2W5efYZ8DQmQDusjXcVYWWU3ZuUVZu6/E2ElK3rhKcvKVcOiAutDQ+9cv5nq899bowKMpOWR1kO1sar93E8+wWarRnLF6YHeis1/Ny0Do0jpiwhLntDSPEsnEiYRdV4htKfFTCuNrAZhSxtV+VdNSnmAG0doYqLvEaq5Qn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YhwjPKRe; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hu70RlKq; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YhwjPKRe";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hu70RlKq"
ARC-Seal: i=1; a=rsa-sha256; t=1784704657; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jRXspzPBA4JLpTwH8UEm07LkKDV/nt1KD6WNBAuUJurWwPRB4WfifSqH6e2mptk4Q/
    U5ngLeAIE341FueE7W/NUpWBOm1nWSPtH9FZDE2YrZdB5fLTyuR1GRXJ2vIJMV5r08W5
    J50HuMfB6stXorKxHpU9xIo+xCcdXuBaHLU1wJ+vImQfCt3yQl/OlfkoRDsJCXnLH36y
    ZJ4vS0CgeSx2yeb5n2m9uCBgPwROfW42LYDSeqkaX82zvHhkS8ofyuPNiqkMSof8DBJZ
    tUR4PwD5HIbvjkLo1QrwHL08p6EAAuSLwoVBECDDhQgCM3le58ygZ70WiZjAj1dmpCVv
    ePSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784704657;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=h4aiYjYGiGQnv1RVZnObjsB/mkFKAKItc14E9XWeBXM=;
    b=fSxPsvc/hRcSqLF1YEB125NgT7WlIWTDhqdRthwvOjHc+r4t/88xE/h/POp4jxBbUt
    nlIODohsESiNwOIIHV+VvpCkHQ1pi3MtyBYIVJBEjRvG3pfH3aQzLPONCBnb6UYKLqRe
    73cPVtpI0KwMMztP9hQ3OSv8hV5R0HpKJybv5CnlgUaKbnQUWEvgmfeTXapCxgV6o19T
    LmmVO/S7zPSiWttLInDKVZzkuhnEKHe8EKH3dtXybhDy9ziwFRu42LjgrMYK0ek4fw3w
    j/5DaYj2qf/IOIToIkkMeEq+Es0g2QBVATvEv+MGCHEAr+AvWK3aM73fdFbZDyXOlmqW
    i4kQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784704657;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=h4aiYjYGiGQnv1RVZnObjsB/mkFKAKItc14E9XWeBXM=;
    b=YhwjPKReA+iQOgGB3RGZ5+/QxFXR62lvGd+04v/iQ7tS6IjFUsY6Z5kvFwMafFo0e1
    CVnHxIa4jqfY0hU/RUcNe+sFCOStVa4feDhxaErDj3tC7xS1vttQ1BlXSyVIXKAMhixD
    u+hWDUgurBt7+RjUpCBOEIdle2jgKvzjNCUWJq9EAREW5H3y/ok9KQrBAyjZGvK7fUzk
    r1YtnW22x/XCxN5aYG5FlR/UcH2/6q5KG1d1sZ6iiov5tx4EbLlxHHTy3/tV8g+MW3Il
    KywKri5WDnVvYH+twuiwIAsvwP9m5VC5KYeRE43vJ5C5RES5DoaFHvwMkpIPpIQ7Vws9
    Aaxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784704657;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=h4aiYjYGiGQnv1RVZnObjsB/mkFKAKItc14E9XWeBXM=;
    b=hu70RlKqBaeuLlSiFRUo8Z1X18QfDZ4eyOxhFEvMiddcRzFcrOrJKAw7RBJ5AGmFgD
    e12yOP8RfxuxA33igtAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.219]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id K5281926M7HasBR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 22 Jul 2026 09:17:36 +0200 (CEST)
Message-ID: <a6d7eacc-48cb-4f6c-9672-b81e5050d8b6@hartkopp.net>
Date: Wed, 22 Jul 2026 09:17:30 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: softing: validate firmware record spans
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260722044347.2708-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260722044347.2708-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

thanks for the patch!

In fact I was thinking about entirely removing this driver.

I am not aware if anyone still uses this over 30 y/o hardware in 2026.
Since I changed my department in 2017 my last Softing CANCard was 
accidentally thrown away at a clean up attempt.

IMO neither this PCMCIA Card from 1994 nor some Linux hardware with 
PCMCIA slot would still run Linux 7.2 today where a 13€ CANdelight USB 
adapter would do a better job.

So thanks but I tend to remove the softing driver instead of creating 
the effort for a stable patch series.

@Marc/Vincent: I still have two SJA1000 memory-mapped (no firmware!) 
PCMCIA CAN cards from PEAK and EMS Wuensche on my desk - and a Centrino 
Laptop from 2006 with PCMCIA slot. But I wonder if we should remove the 
entire PCMCIA CAN drivers while we are at it?

The last fix that I reviewed and tested on my Laptop was from 2021:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=3ec6ca6b1a8e64389f0212b5a1b0f6fed1909e45

Best regards,
Oliver


On 22.07.26 06:43, Pengpeng Hou wrote:
> fw_parse() reads a fixed record header, a firmware-provided payload,
> and a trailing checksum without knowing the end of the firmware blob. A
> truncated record can therefore make those reads exceed the blob.
> 
> The same record also supplies addresses and lengths for writes into
> DPRAM. The generic loader uses wrap-prone mixed signed arithmetic for its
> bounds check, while the application loader does not bound the staging
> copy at all.
> 
> Pass the firmware end to the parser and validate the full source record.
> Use a signed wide offset for generic DPRAM records and validate the
> application staging span against the mapped DPRAM before copying.
> 
> Fixes: 03fd3cf5a179 ("can: add driver for Softing card")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   drivers/net/can/softing/softing_fw.c | 46 +++++++++++++++++++---------
>   1 file changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/can/softing/softing_fw.c b/drivers/net/can/softing/softing_fw.c
> index 721df91cdbfb..282570daf3ef 100644
> --- a/drivers/net/can/softing/softing_fw.c
> +++ b/drivers/net/can/softing/softing_fw.c
> @@ -91,12 +91,12 @@ int softing_bootloader_command(struct softing *card, int16_t cmd,
>   	return ret;
>   }
>   
> -static int fw_parse(const uint8_t **pmem, uint16_t *ptype, uint32_t *paddr,
> -		uint16_t *plen, const uint8_t **pdat)
> +static int fw_parse(const u8 **pmem, const u8 *limit, u16 *ptype,
> +		    u32 *paddr, u16 *plen, const u8 **pdat)
>   {
>   	uint16_t checksum[2];
> -	const uint8_t *mem;
> -	const uint8_t *end;
> +	const u8 *mem;
> +	const u8 *record_end;
>   
>   	/*
>   	 * firmware records are a binary, unaligned stream composed of:
> @@ -114,14 +114,21 @@ static int fw_parse(const uint8_t **pmem, uint16_t *ptype, uint32_t *paddr,
>   	 * endianness & alignment.
>   	 */
>   	mem = *pmem;
> +	/* A record needs an 8-byte prefix and a 2-byte checksum. */
> +	if (mem > limit || limit - mem < 10)
> +		return -EINVAL;
> +
>   	*ptype = le16_to_cpup((void *)&mem[0]);
>   	*paddr = le32_to_cpup((void *)&mem[2]);
>   	*plen = le16_to_cpup((void *)&mem[6]);
> +	if (*plen > limit - mem - 10)
> +		return -EINVAL;
> +
>   	*pdat = &mem[8];
>   	/* verify checksum */
> -	end = &mem[8 + *plen];
> -	checksum[0] = le16_to_cpup((void *)end);
> -	for (checksum[1] = 0; mem < end; ++mem)
> +	record_end = &mem[8 + *plen];
> +	checksum[0] = le16_to_cpup((void *)record_end);
> +	for (checksum[1] = 0; mem < record_end; ++mem)
>   		checksum[1] += *mem;
>   	if (checksum[0] != checksum[1])
>   		return -EINVAL;
> @@ -139,6 +146,7 @@ int softing_load_fw(const char *file, struct softing *card,
>   	uint16_t type, len;
>   	uint32_t addr;
>   	uint8_t *buf = NULL, *new_buf;
> +	s64 dpram_offset;
>   	int buflen = 0;
>   	int8_t type_end = 0;
>   
> @@ -153,7 +161,7 @@ int softing_load_fw(const char *file, struct softing *card,
>   	mem = fw->data;
>   	end = &mem[fw->size];
>   	/* look for header record */
> -	ret = fw_parse(&mem, &type, &addr, &len, &dat);
> +	ret = fw_parse(&mem, end, &type, &addr, &len, &dat);
>   	if (ret < 0)
>   		goto failed;
>   	if (type != 0xffff)
> @@ -164,7 +172,7 @@ int softing_load_fw(const char *file, struct softing *card,
>   	}
>   	/* ok, we had a header */
>   	while (mem < end) {
> -		ret = fw_parse(&mem, &type, &addr, &len, &dat);
> +		ret = fw_parse(&mem, end, &type, &addr, &len, &dat);
>   		if (ret < 0)
>   			goto failed;
>   		if (type == 3) {
> @@ -179,9 +187,13 @@ int softing_load_fw(const char *file, struct softing *card,
>   			goto failed;
>   		}
>   
> -		if ((addr + len + offset) > size)
> +		dpram_offset = (s64)addr + offset;
> +		if (dpram_offset < 0 || dpram_offset > size ||
> +		    len > size - dpram_offset) {
> +			ret = -EINVAL;
>   			goto failed;
> -		memcpy_toio(&dpram[addr + offset], dat, len);
> +		}
> +		memcpy_toio(&dpram[dpram_offset], dat, len);
>   		/* be sure to flush caches from IO space */
>   		mb();
>   		if (len > buflen) {
> @@ -195,7 +207,7 @@ int softing_load_fw(const char *file, struct softing *card,
>   			buf = new_buf;
>   		}
>   		/* verify record data */
> -		memcpy_fromio(buf, &dpram[addr + offset], len);
> +		memcpy_fromio(buf, &dpram[dpram_offset], len);
>   		if (memcmp(buf, dat, len)) {
>   			/* is not ok */
>   			dev_alert(&card->pdev->dev, "DPRAM readback failed\n");
> @@ -237,7 +249,7 @@ int softing_load_app_fw(const char *file, struct softing *card)
>   	mem = fw->data;
>   	end = &mem[fw->size];
>   	/* look for header record */
> -	ret = fw_parse(&mem, &type, &addr, &len, &dat);
> +	ret = fw_parse(&mem, end, &type, &addr, &len, &dat);
>   	if (ret)
>   		goto failed;
>   	ret = -EINVAL;
> @@ -253,7 +265,7 @@ int softing_load_app_fw(const char *file, struct softing *card)
>   	}
>   	/* ok, we had a header */
>   	while (mem < end) {
> -		ret = fw_parse(&mem, &type, &addr, &len, &dat);
> +		ret = fw_parse(&mem, end, &type, &addr, &len, &dat);
>   		if (ret)
>   			goto failed;
>   
> @@ -279,6 +291,12 @@ int softing_load_app_fw(const char *file, struct softing *card)
>   		/* work in 16bit (target) */
>   		sum &= 0xffff;
>   
> +		if (card->pdat->app.offs > card->dpram_size ||
> +		    len > card->dpram_size - card->pdat->app.offs) {
> +			ret = -EINVAL;
> +			goto failed;
> +		}
> +
>   		memcpy_toio(&card->dpram[card->pdat->app.offs], dat, len);
>   		iowrite32(card->pdat->app.offs + card->pdat->app.addr,
>   				&card->dpram[DPRAM_COMMAND + 2]);

