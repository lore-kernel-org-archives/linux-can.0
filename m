Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C21D3B6BF5
	for <linux-can@vger.kernel.org>; Sat,  1 Aug 2026 05:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785562627; cv=none; b=U++jyPlJoqwLgp29HBQ/u6hkn2l09SbqiDfXQ4GSPPdliHxK6UpDSEYhE38Zr60tfuy0w7xQ2MwueogzzwDpKsoVP7NCBu3Yk8qRJdblhRlSnK5E7r4g4pVUQglvYLmsQyvxV+1AWhP/L4XTdMlLn1imTROzKPO9yOnElJJGhLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785562627; c=relaxed/simple;
	bh=59nG9aVpiGe8WTx4v24lBgoYq+SAlcJNegUoQ14KnOQ=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=PQhGB8m9pEfwQQHu+d+0g9TFMjFfUo98+3i5evz26tUZDp2wkYEfWV3KYBjf2QpWF9p+yvArmfghPGiD0evKTnC2zEsgA8hSEX9yINq8MdRim3kD+Em+bDf2unsnXs0W1TUA7xkG/dLhUa/u42LMuYCJDHZbo4BxDFeLS4Cssgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Go6ondOv; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Go6ondOv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785562614; bh=59nG9aVpiGe8WTx4v24lBgoYq+SAlcJNegUoQ14KnOQ=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=Go6ondOvX2h05y5eGlj0QFw/gjVjrs0dGEEDAsHT7u9naoHiDmmX5rj7NAogdw6T7
	 lTVvjqsfr0odWuss9B++KSY3iYhc4CtLqhkklbX2tFy9q9zXAJWG2TRRa9zF00UxAI
	 wNynee0A1kW+RnWytn9kZs3jV363fcXnUSzEXTFk=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-XMAILINFO: NWthGbMT/5RHpdKC/bezqCfGvA53eNNAETF/3fVGRxt+Iy5rTD1nG897rlS7ag
	 P+nDsx+b4QCuSz5pBKvNg6kHrhlm6qp+Qxo3Byf76xSPSLqGObSunOI/gwX3Uv1u2xz4zi+4o7uqx
	 ZIXMUVtUhzg9IJqayt3lSPkwyhxCXMgf2kCR/aiRNRqvBetlCAionr8BPal2FYG5rCPgbywH7SENU
	 Cb4WC2AYxy2rLM+9uoGlx4gPGvAxIgaGEBI215tnNYVSt7AkDP2t/U4FW0yKBndgj7sx2U7q1Q6cV
	 Ar6CexAJdALjUtblB7MnAkEzpoHK8hQhVn3OG49hxygSEGDNYQScpJ31WXKUl36uT9t4Kyuiu1kXp
	 XCBO1TUaj3IR4wYLh5WKODzZiDynX22sKkQAvRvIzozmk933S/oFBCriUsf8YIrqs1APp25qt2b/t
	 O8r4r9JNiDev0ICffpMjKfTetffByU+FX6IR2/zqxqAqHfLSjNznKwuZBOhUcNSJlA7/IoTg08Xo1
	 QnfL3SOR3Ck67aPseB3iNHSXUp6M8ucirEWv9kt5kvs76u1NreLMml2XKIO9GbHnk7pnCA4FwBlu+
	 sEfKcmwwDMYiciRNST2ObN+X+0MX8eyKdJzk4tw8Wvg0YlEkw+7G0RHhDYn3qYbZbUhDon1/uzmiB
	 O8+Xm7Tr9eZKBs2EDdBfxcEUiPs63haWA5TVCH+mL+aeQVnrwV3N3vYi3+TcWqgT9E3SiqCCmQj9R
	 Onx3SDM7XmyIYwRkB6Z2LtAMR1UknoZvlzwIpbiPnYPnbaHZ291NCT4HC1DTZ+jTkckkXK88c6y78
	 XKSFP/Mu0HU0RIE5E0CpvXYRqlP8fiEdnb3YMGs+g1yjb2LJXoc/3+po09Ax+JKl8KIsNcyN5q/LF
	 7bVYznw1zOAAlvgqhbtYcMTdq4XnzgUIQ8TcPj7J2L6fYxUknYLQxq9ao7YJFfEjSDEjR+hA/+F06
	 a56wbjr6WYjvk0BXfJPBeHMujBWsZEIj4YVcpm/4tmgpuXKrEDDTqwpmQ44ufbJvn+Q40MscI+jbj
	 Frtv0t3FsD0eLZZ8PwTk5mRRikIYbpPPbesnQEUtN4ttg6moCAfZu6DJ57GqGz9jLVn144wijcQ8j
	 Tc5oPKp40etKKQ==
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?c2FzaGlrby1yZXZpZXdz?=" <sashiko-reviews@lists.linux.dev>
Cc: "=?utf-8?B?T2xla3NpaiBSZW1wZWw=?=" <o.rempel@pengutronix.de>, "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?T2xpdmVyIEhhcnRrb3Bw?=" <socketcan@hartkopp.net>
Subject: Re: [PATCH v5 1/3] can: rockchip_canfd: prevent TX stall on echo skb failure
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 1 Aug 2026 13:36:52 +0800
X-Priority: 3
Message-ID: <tencent_9C071822E2F9F135F1D2FCCA4C25488C240A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260731-master-v5-0-5b27029dee20@qq.com>
 <tencent_C82C09E7235101CC88A97E154D2534183208@qq.com>
	<20260731105402.B7A451F000E9@smtp.kernel.org>
In-Reply-To: <20260731105402.B7A451F000E9@smtp.kernel.org>
X-QQ-mid: xmsezb41-0t1785562612tam989e4v

SGksCgo+IElmIGFuIEVUSF9QX0NBTlhMIGZyYW1lIGlzIHNlbnQgdmlhIEFGX1BBQ0tFVCwg
Y2FuX2Rldl9kcm9wcGVkX3NrYigpIGN1cnJlbnRseQo+IGxhY2tzIGEgY2hlY2sgdG8gZHJv
cCBDQU4gWEwgZnJhbWVzIGZvciBkZXZpY2VzIHRoYXQgZG9uJ3Qgc3VwcG9ydCBDQU4gWEwu
Cj4gV2hlbiBzdWNoIGEgZnJhbWUgZW50ZXJzIHJrY2FuZmRfc3RhcnRfeG1pdCgpLCBjYW5f
aXNfY2FuZmRfc2tiKCkgcmV0dXJucwo+IGZhbHNlLCBjYXVzaW5nIHRoZSBkcml2ZXIgdG8g
dHJlYXQgaXQgYXMgYSBDbGFzc2ljIENBTiBmcmFtZS4KPgo+IFRoZSBkcml2ZXIgcmVhZHMg
Y2ZkLT5sZW4gZnJvbSBvZmZzZXQgNCwgd2hpY2ggaW4gYSBjYW54bF9mcmFtZSBjb3JyZXNw
b25kcyB0bwo+IHRoZSB1c2VyLWNvbnRyb2xsZWQgZmxhZ3MgZmllbGQuIEJlY2F1c2UgdmFs
aWQgQ0FOIFhMIGZyYW1lcyByZXF1aXJlIENBTlhMX1hMRgo+ICgweDgwKSB0byBiZSBzZXQs
IGNmZC0+bGVuIGlzIGV2YWx1YXRlZCBhcyBhdCBsZWFzdCAxMjguCj4KPiBDb3VsZCBhIG1p
bmltYWxseSBzaXplZCBDQU4gWEwgZnJhbWUgdHJpZ2dlciBhIGxvb3Agb2YgMzIgaXRlcmF0
aW9ucyBoZXJlLAo+IGxlYWRpbmcgdG8gYW4gb3V0LW9mLWJvdW5kcyByZWFkIGZyb20gY2Zk
LT5kYXRhIGFuZCBhbiBvdXQtb2YtYm91bmRzIHdyaXRlCj4gdG8gZGV2aWNlIG1lbW9yeSBh
dCBSS0NBTkZEX1JFR19GRF9UWERBVEEwICsgaT8KClllcywgeW91ciBhbmFseXNpcyBpcyBj
b3JyZWN0LiBBIHZhbGlkIENBTiBYTCBza2IgY2FuIHBhc3MgdGhlIGN1cnJlbnQgY29tbW9u
CnZhbGlkYXRpb24gYW5kIHJlYWNoIHJrY2FuZmRfc3RhcnRfeG1pdCgpLCBldmVuIHRob3Vn
aCB0aGUgUm9ja2NoaXAgY29udHJvbGxlcgpkb2VzIG5vdCBzdXBwb3J0IENBTiBYTC4gVGhl
IENBTlhMX1hMRiBiaXQgaXMgdGhlbiBpbnRlcnByZXRlZCBhcyBjZmQtPmxlbiwgc28KdGhl
IGRhdGEgbG9vcCBjYW4gcmVhZCBiZXlvbmQgdGhlIHNrYiBmcmFtZSBkYXRhIGFuZCB3cml0
ZSBiZXlvbmQgdGhlCmNvbnRyb2xsZXIncyA2NC1ieXRlIFRYIGRhdGEgcmVnaXN0ZXIgd2lu
ZG93LgoKVGhpcyBpc3N1ZSBwcmVkYXRlcyB0aGUgY3VycmVudCBwYXRjaCBhbmQgaXMgaW5k
ZXBlbmRlbnQgb2YgdGhlIGVjaG8gc2tiCmZhaWx1cmUgaGFuZGxpbmcgYWRkcmVzc2VkIGhl
cmUuIEkgd2lsbCB0aGVyZWZvcmUgbm90IGZvbGQgaXRzIGZpeCBpbnRvIHRoaXMKcGF0Y2gu
IEtlZXBpbmcgdGhlIGZpeGVzIHNlcGFyYXRlIGFsc28gYWxsb3dzIHRoZSBDQU4gWEwgdmFs
aWRhdGlvbiBpc3N1ZSB0byBiZQphZGRyZXNzZWQgaW4gdGhlIGNvbW1vbiBDQU4gdHJhbnNt
aXQgcGF0aCwgc28gdGhhdCBvdGhlciBub24tQ0FOLVhMIGRyaXZlcnMgYXJlCnByb3RlY3Rl
ZCBhcyB3ZWxsLgoKSSB3aWxsIHByZXBhcmUgYW5kIHBvc3QgYSBzZXBhcmF0ZSBwYXRjaCB0
byByZWplY3QgQ0FOIFhMIHNrYnMgd2hlbiBDQU4gWEwgaXMKbm90IGVuYWJsZWQgb24gdGhl
IHRhcmdldCBDQU4gZGV2aWNlLgoKVGhhbmtzIGFnYWluIGZvciB0aGUgZGV0YWlsZWQgcmVw
b3J0LgoKQmVzdCByZWdhcmRzLApDdW5oYW8=

