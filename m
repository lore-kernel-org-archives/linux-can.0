Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DDE4D598B
	for <linux-can@vger.kernel.org>; Fri,  9 Oct 2026 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557393; cv=pass; b=HYas6zjnl1oZcBJeyuUvEIstDgvWHnFl8LxgBDraUR1j5cogugOvIrIikN5dRwo6lIkv2z1GY00Pw06cm5xHVxsNDecVZ6lH1RMdGfREZfSbfeDRXolIjCFu7mHL/B4Yx0P64eDpSquZA9v2Qpmrj895sWxKhZT+LW2KGZz1zIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557393; c=relaxed/simple;
	bh=XmyT51B1vAeaGig1MdEnmdA0dmnji7b7qeOSMgYiIYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=QIf1Ldijb88WT1+vdbvv1aqXpzvoZ51WSmtj43AVCXZh0rBAGGN83kaPP+u79IeoKO3pVoHMC71sJc5AQ+Vg0MVmDpWMdZRAJmGPWr2rvyjx+obcE0PkIUDbjqmgT5liNtSK5qdWIHhPK/8YbfEwiWm89EpOPIGIiGlKvkBTPr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZUClg/ho; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=35jTeFCX; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZUClg/ho";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="35jTeFCX"
ARC-Seal: i=1; a=rsa-sha256; t=1791557199; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MJl5NA5RDe6cxJaqc+GlNiFZ8WvUCh6N9Kz3u6O19qfATix+ElaLqACcA9fQBWQ+UW
    1fHKd0XSN8AxPkiXAJeDg6BKWyWhkjS94GgIsTYgxKqwY7ix0OBqy+b1zQTyWAILEAUg
    ak3ySXLYZPyWQHfAPbVZ0/bNMwyg+d8FuErDACZVzKS2GOEcj4/IpuDfRa9PFsTdb7U9
    mI8U6oDoSnmJQ8U9TD30/Tp32YXRDiJPPYm97efqQTeiP+69r31GzdBEsX34CEGkOXlv
    XzBa7666TNKIxvglCeSEa4c1Cy5md2AxYFKAsmzC77IAFNciSGVY41RZwtM9d3uNvTNO
    d52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791557199;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zwRr8mwXFShNYbRubE/7ivQr3Z47XmbaIGb++3v3rcM=;
    b=Tk+BPFVGR3Sl7Ecn7RrvOPJyUQqiHiysypOGQtNNJycyXxXWcOSuJH01mBbVGUxhM4
    WB+X5waQLRV6tOApR0ynj6dEDWEH0HJaQw9DUGAB6s+0aak8Icq+8aE483Cc8uLDdpnh
    BpEo7TmsXSjPXFHb6UAR9BwmzqCc4h0UkYMPgf4S5uNjmjk9VggLKpmzDx5eIM0ofL+K
    KzmiAVFGvO8eQkayk1zNEtNU6XHniknUHHvV/PrVYzLl17x/G7kDkMaLSxeipqkzZwha
    pQJT4NuosDe1Qzv3kMYUbU2XrOfOT7M715tVkHhz86W8uBP5gHLgSJI/ElmMWQwRJTgX
    91Ng==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791557199;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zwRr8mwXFShNYbRubE/7ivQr3Z47XmbaIGb++3v3rcM=;
    b=ZUClg/hog+vzGNc5SjGsf9vOzcI5LU/Kv0jJXtxiI/aGWwhy+stmVGflF4nQBJjkUa
    8RlkU+i7qLXM9C24NYt3AOi61BO14oIAjNqUeLBNAUk1fppUmsTJpRWc8qSBvUGHKsEJ
    RgBt7fM8VOdfY9CmxjyUOo5wA4H+WsExl6m0CpeAoK55nvqFvRphC3DD0/dTi2vdgsuK
    fqgmKfyrcU9tlFi4XGFmjc4yjD/ngUr9+/PldYfg9VWooZYAp7yJyY5FAJYzuQofJTat
    lYdhKIsHN0nnwMljWHB9JTwRz/ZaGy568a3qYAs54r9d/pTtFQkF1PIwSx2JEvj45fln
    /s5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791557199;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zwRr8mwXFShNYbRubE/7ivQr3Z47XmbaIGb++3v3rcM=;
    b=35jTeFCXxqrcCP1nawwnX38+LYzzAqXBZy2AcmtxPzZ/dHbOZWOnhGX7KcBscevcwG
    FWe08BGyy1+etNuNlYCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a299EkdVdx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 9 Oct 2026 16:46:39 +0200 (CEST)
Message-ID: <14f90123-382a-42fe-942a-b62f14307c85@hartkopp.net>
Date: Fri, 9 Oct 2026 16:46:39 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/37] pull-request: can-next 2026-10-09
To: Marc Kleine-Budde <mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
 <20261009-bulky-normal-collie-00a67a-mkl@pengutronix.de>
Content-Language: en-US
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261009-bulky-normal-collie-00a67a-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Can you please push the testing branch?

Thanks,
Oliver

On 09.10.26 15:57, Marc Kleine-Budde wrote:
> On 09.10.2026 15:27:32, Marc Kleine-Budde wrote:
>> Hello netdev-team,
>>
>> this is a pull request of 37 patches for net-next/main.
>>
>> The first patch is by Vincent Mailhol and drops CAN-XL frames on non
>> CAN-XL devices.
>>
>> A patch by Sang-Heon Jeon removes a redundant NULL check before
>> netdev_hold() in the CAN RAW protocol.
>>
>> Oliver Hartkopp's patch converts the unreliable ARPHRD_CAN type check
>> to the robust can_get_ml_priv().
>>
>> A patch by Runyu Xiao for CAN proc resets the pkg_stats using atomics
>> individually. Oliver Hartkopp also contributes a patch for the CAN
>> proc to remove kernel pointers from the output.
>>
>> Tetsuo Handa's patch cancels pending address claim timers in
>> j1939_ecu_unmap_all().
>>
>> A patch by Kaixuan Li for the CAN ISOTP protocol improves the check
>> for the correct CAN CC/FD frames.
>>
>> The next 3 patches are by Cunhao Lu and make CAN skb freeing safe in
>> any context in several CAN helper functions.
>>
>> Claudiu Beznea contributes 5 patches for the rcar_canfd driver to add
>> support for Renesas RZ/G3S.
>>
>> Krzysztof Kozlowski's patch updates the renesas,rcar-canfd DT bindings
>> to restrict the resets in top-level.
>>
>> Biju Das's series of 3 patches add support for Renesas RZ/G3L CANFD to
>> the rcar_canfd driver.
>>
>> Quchaosheng contributes 2 patches to convert the gr_can DR bindings to
>> DT schema.
> 
> Forgot to mention, that a patch by Oliver Hartkopp removes the Softing
> CANcard driver.
> 
> regards,
> Marc
> 

