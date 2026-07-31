Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C823B47DD;
	Fri, 31 Jul 2026 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785489841; cv=none; b=TI8FhyRWXX6my35WZdjikqvg+ckuslpuaZoTZgsh0DlX0nQXiD+iJA3QHLdB0K80h/nQ467e8iPfztqaEDwZhVS54o5+4qBaYPIZecUOwRZk3pWJizzwBGC+S6dU7lhSRKGLgWlgR0JYPnoryBQsVxT6dfk+xY31pADuC333GF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785489841; c=relaxed/simple;
	bh=XiIiDwni9OurStl7pRO7ZhqiyVf3ygxX/NwmFxj//ws=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=CTmRY1aYy9oli79g+diaIplJfFfebcYa8aUIgc9H1wwtIibjLeXJsLW/6EtQlXy4kul4CWNQ96qHHcTOpeFHxAuMmTAOemKup/FYjuvPtEDQLD/y0IrEfLRveMcEbJQbLdqsBhFd4JLPcyuo2Qo8ydaWhmcsLqjCI/qYAjj2JBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZL3eO6DV; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZL3eO6DV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785489828; bh=XiIiDwni9OurStl7pRO7ZhqiyVf3ygxX/NwmFxj//ws=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=ZL3eO6DVQIr4Re4Al7cmK8X9Yn21ixyz5yaCqpOiw08ChgoqiY6xNOM93bhhwnPTp
	 dKIIkuswSpFmhQZGkLEy9z8ccuh+nP85/TsCYnw2AfH3omeay7NKNshFIOxYzBlUTV
	 hLA7yVo8zC8dsJ2TeI1nuNcZtpyJxjPHjmKOSkOE=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-XMAILINFO: MdmyWVu0InhASr51t+bh5d00P15ddVfHxAAtw92Y7cy3+tpnleiyxscsCHM8Bo
	 HSoDUv9Jf67J6A3E7utHTCs2SbiQJE8/ph1uWVKiD7IE0TRGiCeLNpYazT8JzJ3hr2voI7hPsH6CP
	 ZxQH+Swm4aeJrx0+igr8sq7KaMbwxRoN9LlV7Argn70rFcUVWc48AtF06Gq6ZIrQh+hVRKq5AuteS
	 ecODuSy08oGNSTrMwnvLTWT6DqvcH48rvKPWBy8AvxeW0lEHDqLYtp8rLsmDdQv8PFICHk7IOWd4y
	 3O5RbwiPsT7V64ACizMdduFJDLgxpPdn5R1+LpFYlpEKBlCNymOiHGmDEaSlsVai8njwfmGuYS4ZO
	 689FqoE8+UHVXA/i0zkcQjsbZP2ubdv/l5N1QbaXHRyJ2z6qssJ76xODSrUzCPgWSZFtc92u1CKFb
	 4v8qomZy8F0fxpdvtsBEuSbxPF4DXWo08a/aQZIrRAPED/pbWRQU0O/CmTJC/OvBnR9x1oAw8k6sZ
	 DEaHz6IkPmRQqsTQR2KOcaRYYHQHzPAiZVxp8FLinJcPWE52db1akCY+b/b53xi2719JzlQosPPhW
	 vijCRzF37jWJIKcfIX8UHNxjWISuORHK/UMx9BTPsIKHSzDkwrqOpJmddcd5rqEHHP8641djsgkRS
	 iG12O6VTtWCri6mIkN8dAOF597q15Bqw3GqiYfWAc1A2FiP3isVovb1Sv/oo9t2uVVE3WrpDJijvp
	 jhBuKJJ66Ck/2oxzVC/iDshGZApclmOOraBBaFOGL5/2bzsNDh487HP/Zbybcs6ALpVo/coYc5sdM
	 sRYUPfYbkwc2kr5zfCtUnZUzEuy5uEJYRJCC5OY3ABWmN3HRCaxH+OiX2NaU3XOeg0eK7rV8PdkiA
	 2cyY8xplPH+0oCcoaf99G8+QTZmjqa4SJKcyMf7dVifyv4C0emQEYBFYklQHOBq0h9kieSz4AIQ7+
	 s7WIcXMg5DgKuWwU5RDo0wHVww9d3JpKgwu7C70aFsah+5ofxmpj6kqK5V8rExW4DlWPOpX4NhgKp
	 2uOZrfahfc/QbVtNc+Xy2Y2PXBF5PXGVe7K9flomXjDpD7+E=
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>
Cc: "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v6 2/4] can: rockchip: add RK3588 CAN support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 31 Jul 2026 17:23:45 +0800
X-Priority: 3
Message-ID: <tencent_A3698A465C4621E164443B0005D1CC6FAE05@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_7BAA0052C402BFFD26291A64198084E39107@qq.com>
 <tencent_207E464D12344B3228096E23A001D6882508@qq.com>
	<20260731-tall-camouflaged-earthworm-e1a7d0-mkl@pengutronix.de>
In-Reply-To: <20260731-tall-camouflaged-earthworm-e1a7d0-mkl@pengutronix.de>
X-QQ-mid: xmsezb41-0t1785489825tvu85u5sk

SGkgTWFyYywKCj4gQ2FuIHlvdSBhdHRhY2ggdGhlIFREQyB0byB0aGUgQ0FOIGZyYW1ld29y
az8gU2VlIGNvbW1pdCA1ZTE2NjM4MTBlMTEKPiAoImNhbjogbWNwMjUxeGZkOiBmaXggVERD
IHNldHRpbmcgZm9yIGxvdyBkYXRhIGJpdCByYXRlcyIpLiBBbmQgY2hlY2sgaWYKPiBDQU4t
RkQgd29ya3Mgb24gdGhlIHJrMzU4OCB3b3Jrcz8KCkNvdWxkIHdlIGxlYXZlIHRoZSBSSzM1
ODggVERDIHN1cHBvcnQgb3V0IG9mIHRoaXMgcGF0Y2ggc2VyaWVzIGZvciBub3c/CgpJIHdp
bGwgdGVzdCB3aGV0aGVyIENBTi1GRCB3b3JrcyBvbiBSSzM1ODggd2l0aCBUREMgaW50ZWdy
YXRlZCB3aXRoIHRoZQpDQU4gZnJhbWV3b3JrIGFuZCByZXBvcnQgdGhlIHRlc3QgcmVzdWx0
LiBJZiB0aGUgdGVzdGluZyBzaG93cyB0aGF0IGl0CndvcmtzLCBJIHdpbGwgZW5hYmxlIGl0
IGluIGEgc2VwYXJhdGUgZm9sbG93LXVwIHBhdGNoLgoKVGhhbmtzLApDdW5oYW8=

