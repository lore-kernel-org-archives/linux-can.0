Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C706F2264A7;
	Wed,  3 Jun 2026 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491241; cv=pass; b=E1zMme4b55sEtweqt4d2S/mmHiIDZ1dRc2Dv9yeXZTInfOhoO/aajwzqagM82W1gbWBVxaNvVZifkszoOTWC7LvPgCB3TrnPoBT7jyHBl4GpZobp0IEgn8k8D5PFLS3I+2S8cXI5dDbjXdky55uMRcvRqhAxDjy6I1ysNRfpmT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491241; c=relaxed/simple;
	bh=N0r0/FJRU8FYET34La8UGAEpoLuB68ut3JwehoeYLqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlTgWB/zBnreUNsYM+nZ4/sI+2FNvISbkICiXX7+pcdWHi/b5ehr4b4KwkPQA5BmHs8kp8j02wtgpDYW/1ZXf2INcGHtTJDMluubSr2DUcqbd063RETxAXmDZfLjEzFBsVY7f8PxSuUQJQNQY3ZzqxEz8NZhBtRkokt6ZSyC9PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Pz/PQ8J+; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=+1VDuUj8; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Pz/PQ8J+";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="+1VDuUj8"
ARC-Seal: i=1; a=rsa-sha256; t=1780491051; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=J7dM+qog8oZThHuDABETXOdQlYL3JZSGY1gkmGy4/FLV81LNQ5sdaK/pwKNMk4RwmG
    I3t3Tlez8TMij+HXaeYlSIinvDhm7L/U+5THZzdL94CeFClxQs7zfpC4dnLv/gqmxj7Y
    PFASXynBGhH51GjoiA8XwWl7exwyGfJsgIvNBOBct067CXMBGV40cOd/ckaq79+Mb6fH
    qlmWfmOr1x/Hr/QllD+OEn2+utEKbDCRIn8UkUoFgu5CTHibD7wcITcjEmBqkc5uPHLg
    13r29qBPP54TeMMUKi/mstLDPz0KDvrnkvxvXSG5c/ykeWQbNy/czsrVjDYXToDfzfJE
    QgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1780491051;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rt+5p90dyAdQVIbs7nxq88gbTVhCl35Ll+6dLcBfYi8=;
    b=e21VY9cN1zpgR7frh7tL1XvVd2269Wh4iJ2PkqPGW1EXBrq7ZQrNrbLn0tRA3WrAjj
    qQIjx4J6veMq2AlwEgkNpoU5nPAzY6RUW3WQxCDm7pvQp8nKrmplA5bcs9UxEAwy1Hj+
    ZHSPotWzl0pIUaZut74Xtmp2rPAapN/mLLpwaVLFLZmP/D43WixEDivJe9SDww2Q3Y0C
    JbIZYpNiWVvmayNv07DBi8i+yO3xlPTD6HFBsZTZJDayysMaNDzZH/tvrdbAWlcogGc8
    17FHnVmSha73GyoYE4KBB7ZJWq3/PKEXcQ73Dxqm4Tv7nRavV9/IPwZCvoC/+XJnHN8s
    e0AA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1780491051;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rt+5p90dyAdQVIbs7nxq88gbTVhCl35Ll+6dLcBfYi8=;
    b=Pz/PQ8J+ly4xXbKEIAX23i33HvPhVY7Kt9WaPFJUvQlwSnFKgM4x5uUeXj+TuK6/xs
    EBZbiEwQSCYZotNg92B9sZ6x27VdueymGXmVs3AZ0+x5E16gnd2pS1p7qRk/3CE99XP8
    v6Ur0tsuwWxV7l8RBgyHcfgsK5XkuXDoddV9bfmal1RFvXGKAczqdWsiajx9V3PYgDkl
    CcyLarhRJL0SOOKPUW4Xe5fwJ9yL9ShREv84BkgZYIpLBN1EwKMXJTLJ/dF+Kp1Pnqx7
    sqsgdV6OnbtjXJH81kK8dTL+cVdZfryuoHJo2L8qNGx2I1SiRIW18K5i3Q2t+ynTfg60
    wQ3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1780491051;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rt+5p90dyAdQVIbs7nxq88gbTVhCl35Ll+6dLcBfYi8=;
    b=+1VDuUj81BzZJGBRyqhSiF+D+ZXlnNAvXnT9BFkWjagWwnXqs8tb02EiwqiFpQX+lT
    j23U8ZLtpDQZQjHai4BA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.90.236]
    by smtp.strato.de (RZmta 55.0.1 DYNA|AUTH)
    with ESMTPSA id Kba96d253CopWJ6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 3 Jun 2026 14:50:51 +0200 (CEST)
Message-ID: <f83e25e1-b9f5-4810-bbd6-fdb8d2a10c8e@hartkopp.net>
Date: Wed, 3 Jun 2026 14:50:51 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] can: isotp: convert to getsockopt_iter
To: Breno Leitao <leitao@debian.org>
Cc: Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260507-getsock_two_can-v1-0-3c2ae9edfadc@debian.org>
 <20260507-getsock_two_can-v1-2-3c2ae9edfadc@debian.org>
 <14d3ad71-ade2-4d2b-8a67-b0fda3eef2b7@hartkopp.net>
 <aiAcRJ8TBjWhlKhQ@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <aiAcRJ8TBjWhlKhQ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03.06.26 14:25, Breno Leitao wrote:
> On Mon, May 11, 2026 at 09:05:07AM +0200, Oliver Hartkopp wrote:
>>
>>
>> On 07.05.26 11:34, Breno Leitao wrote:
>>> Convert CAN ISO-TP socket's getsockopt implementation to use the new
>>> getsockopt_iter callback with sockopt_t.
>>>
>>> Key changes:
>>> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
>>> - Use opt->optlen for buffer length (input) and returned size (output)
>>> - Use copy_to_iter() instead of put_user()/copy_to_user()
>>>
>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>> ---
>>>    net/can/isotp.c | 12 +++++-------
>>>    1 file changed, 5 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>>> index c48b4a818297e..1c33f09fbd338 100644
>>> --- a/net/can/isotp.c
>>> +++ b/net/can/isotp.c
>>> @@ -1500,7 +1500,7 @@ static int isotp_setsockopt(struct socket *sock, int level, int optname,
>>>    }
>>>    static int isotp_getsockopt(struct socket *sock, int level, int optname,
>>> -			    char __user *optval, int __user *optlen)
>>> +			    sockopt_t *opt)
>>>    {
>>>    	struct sock *sk = sock->sk;
>>>    	struct isotp_sock *so = isotp_sk(sk);
>>> @@ -1509,8 +1509,7 @@ static int isotp_getsockopt(struct socket *sock, int level, int optname,
>>>    	if (level != SOL_CAN_ISOTP)
>>>    		return -EINVAL;
>>> -	if (get_user(len, optlen))
>>> -		return -EFAULT;
>>> +	len = opt->optlen;
>>>    	if (len < 0)
>>>    		return -EINVAL;
>>> @@ -1544,9 +1543,8 @@ static int isotp_getsockopt(struct socket *sock, int level, int optname,
>>>    		return -ENOPROTOOPT;
>>>    	}
>>> -	if (put_user(len, optlen))
>>> -		return -EFAULT;
>>> -	if (copy_to_user(optval, val, len))
>>> +	opt->optlen = len;
>>> +	if (copy_to_iter(val, len, &opt->iter_out) != len)
>>>    		return -EFAULT;
>>>    	return 0;
>>>    }
>>> @@ -1718,7 +1716,7 @@ static const struct proto_ops isotp_ops = {
>>>    	.listen = sock_no_listen,
>>>    	.shutdown = sock_no_shutdown,
>>>    	.setsockopt = isotp_setsockopt,
>>> -	.getsockopt = isotp_getsockopt,
>>> +	.getsockopt_iter = isotp_getsockopt,
>>>    	.sendmsg = isotp_sendmsg,
>>>    	.recvmsg = isotp_recvmsg,
>>>    	.mmap = sock_no_mmap,
>>>
>>
>> Same pattern as in net/can/raw.c that had slipped in via net-next last time
>> ;-)
>>
>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> Thanks Breno!
> 
> Thanks for the review!
> 
> I haven't seen this on linux-next yet. Please let me know if there is any
> update that is expected from my side.

This patch will likely go upstream via can-next.

Marc currently seems to be busy.

Best regards,
Oliver

