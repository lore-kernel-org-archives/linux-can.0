Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9064B44AB68
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792149757; cv=pass; b=KQfzPxRJYCm74D5zjIkHSvE5GHbOm1hj/fIeFvlGiWr+bNSa7gVwG826hOR+DAqo0GRkj1hEKoBqE4JPjUldM4VyceuZ93jjUA+CK+kP0aFjEdgdcdIqqXEFmCoMazJTu235woZ65mc2ypVH2zyHBviNHVfxOhm91AzPOYJ2vmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792149757; c=relaxed/simple;
	bh=/kOPmV6SjXDwMaJw+VUcU6eaWl1Ls6HeEjLhFv9ReZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EA+O2AwcZg5oiSSyWPQggCfgWeeE0z0Hdc8SMzJkW7/yVEbfzR8AMhx7ue2nW+JGR3mZzWcjy9mW/oVf6NFb/hA9jJW0aWwOlzExm1DjiUg4ZuNBpK4KiAbQBLMm3YFFA3aDydd2iiDBE2DfmE1pbg3zTOLRtE/iDoNElD6cSSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=orphQwNS; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Mg8vjRHA; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="orphQwNS";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Mg8vjRHA"
ARC-Seal: i=1; a=rsa-sha256; t=1792149748; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AUxnWhLvemB/KFMNsMCDl2tHLsQW7fjJP6z+yDzX80TqQTNm6+ardMf33fFa/mQoLQ
    gKb2vBpYSnMPVhCjBhVUV4KmG4PJq+ZpL7soCgUGJoYhYI220yWaZ22L6Pjemaq1eKWc
    Z6SNO8kHMrUQLf69qLwGC40jh4CZ08Ru9hlppaW2deqNPS0c9VlzsC32JoZww7fRmfsE
    7VcCMMNU76wf6kPCa6lS+ItgEKWK5RxGEm8AAqO8PGTDAzi9R2HVnX61bdJgr/YJNeV0
    OF69zJkLVfVfb5wWc5Nv/+NYItxw9d+1GBsOAeucXMOIuwATAITX+IuxHHeGN+dw7pWS
    1k/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792149748;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=MdVFFFwPA3zP2kXMS634ob69q4fJnO8l0BTjx0omALA=;
    b=mOqAbMlxmUaWJIrIw4+j/Pctkpa/tuzK8lB4Ghebu0rwTElfMR8WKBM48CgwYUas+l
    +RX+tjzRP1efOQqL9xc55NECW/f5HABZK1pR2U7sj56kGzLQ43j6m1ysEDeTcVEXQtcV
    uAjf3ylukAXwlqqZ9ktYk3tq8YaFRilAMy44zTdK2u/UFUXR5oSrzvVDpidiOwUqUsMG
    JmQ/4qAP8Zv7jEn/MpHYXaeIdU1AOIMHQz1fDQX2ySGYwn+urFJCnnYYfuLLCsD8i3Pw
    99tOFsD2FpnsmyOdNqkOZErVkcUwvZ1bc3J9dQmqk9HzVjHGoTbTi5hw6bMedu+LlRA+
    WTDA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792149748;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=MdVFFFwPA3zP2kXMS634ob69q4fJnO8l0BTjx0omALA=;
    b=orphQwNSv/MXx7eoMEF6kVAYOAsqNNjz/4GyxtVH1OmmTtvyol2BJLYV+Bq2Uc2mPu
    sHZd2GK2Exm9ah2+dti8Lexa7qZvyAtqzUBNz4mErV391Olla6Gw6Ntbgl6886odTwgl
    Q2aWMTiXQrrao0jp8mbDC0GyINzzbLt9pdeThXt0kADHqvPs32zAilqoQwkr4nAgpGUn
    7BK7YZKKFkl01tDbPIWR0LfmvIVpvOChPj7xOf0Sj7SgvAjNvutxgRspydnRbI3gV/jO
    dGaXHiGbCVDCmMowVvQExz8gMN4HhSOexJpkos9eaDXqSDZhDXbLu7Bw0ldmXys9mp+8
    3glQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792149748;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=MdVFFFwPA3zP2kXMS634ob69q4fJnO8l0BTjx0omALA=;
    b=Mg8vjRHAMwiRecZ7MBLKROjSNvN4KJaMe9NXtjMu9gObHUsrE8u01+kV5ju+/ivpHq
    F06druJBVeQQNTdHvFBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29GBMSM1P
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Oct 2026 13:22:28 +0200 (CEST)
Message-ID: <11dab5f5-e94a-44bc-a7ef-a5c04b3cd644@hartkopp.net>
Date: Fri, 16 Oct 2026 13:22:27 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next v3] can: proc: remove pointers from CAN specific
 proc output
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-can@vger.kernel.org
References: <20261016103706.410678-1-socketcan@hartkopp.net>
 <20261016104321.Z9OEG9m_@linutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261016104321.Z9OEG9m_@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16.10.26 12:43, Sebastian Andrzej Siewior wrote:
> On 2026-10-16 12:37:06 [+0200], Oliver Hartkopp wrote:
>> The proc content in /proc/net/can/ and /proc/net/can-bcm/ is intended to
>> check the internal filter lists (af_can, can_raw) and the efficiency and
>> functionality of can_bcm jobs. While exposing kernel addresses was
>> acceptable when this code was written the times have changed and multiple
>> attempts have been made to hash or remove such now sensitive data.
>>
>> This patch removes the disclosure of pointers and instead provides the
>> function names and sock inode numbers when available. When the function
>> name can not be resolved (e.g. KALLSYMS=n or stripped module symbols)
>> %ps would fall back to the raw text address. Therefore (unknown) is
>> printed instead in this case. As there's no known tooling around the CAN
>> specific proc output breaking the ABI with this rework creates no issue.
>>
>> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> I am all fine with this \o/
> 
>> --- a/net/can/proc.c
>> +++ b/net/can/proc.c
>> @@ -189,30 +189,36 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
>>   			      struct net_device *dev)
> …
>> +
>> +		/* %ps falls back to the raw text address when the symbol
>> +		 * can not be resolved (KALLSYMS=n, stripped module symbols)
>> +		 */
>> +		snprintf(symcheck, sizeof(symcheck), "%ps", r->func);
>> +		if (strncmp(symcheck, "0x", 2))
>> +			seq_printf(m, "  %ps\n", r->func);
>> +		else
>> +			seq_puts(m, "  (unknown)\n");
> 
> If you want to keep this because the bot said so, fine. I will let you
> know once my side projects gets through
> 	https://lore.kernel.org/all/20261015-vsprintf_kallsym-v3-1-c175c27f38b7@linutronix.de/
> 
> ;)
> 

Yes, thanks!

"if (strncmp(symcheck, "0x", 2))" is definitely not my favorite 
solution. So I would be happy to simplify the code again once your 
hashed pointer solution is in mainline.

Best regards,
Oliver

